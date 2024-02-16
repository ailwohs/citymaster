local prisoners = {}

prison = {
	['cam'] = {['x'] = 1679.28, ['y'] = 2629.77, ['z'] = 64.45},
	['arrest'] = police.arrest_points,
	['exit'] = {['x'] = 1847.22, ['y'] = 2586.20, ['z'] = 45.67}
}

-- Unjail
TriggerEvent('es:addAdminCommand', 'unjail', 3, function(source, args, user)
	if(#args < 2)then
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Utilisation: ^2/unjail [ID]")
	else
		if(prisoners[args[2]])then
			TriggerClientEvent('es_roleplay:teleportPlayer', tonumber(args[2]), prison.exit.x, prison.exit.y, prison.exit.z)
			TriggerClientEvent('es_roleplay:freezePlayer', tonumber(args[2]), false)
			prisoners[args[2]] = nil
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Le joueur n'est pas en prison.")
		end
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Pas la permission.")
end)

-- Jail
TriggerEvent('es:addAdminCommand', 'jail', 1, function(source, args, user)
	if(#args < 3)then
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Utilisation: ^2/jail [ID] [MINUTES]")
	else

			if(GetPlayerName(args[2]))then
					-- User permission check
					TriggerEvent("es:getPlayerFromId", tonumber(args[2]), function(target)
						if(tonumber(target.permission_level) >= tonumber(user.permission_level))then
							TriggerClientEvent("chatMessage", source, "SYSTEM", {255, 0, 0}, "Tu ne peux pas cibler cette personne!")
							return
						end
					prisoners[args[2]] = true
					local time = tonumber(args[3]) * 1000 * 60
					TriggerClientEvent('es_roleplay:teleportPlayer', tonumber(args[2]), prison.cam.x, prison.cam.y, prison.cam.z)
					TriggerClientEvent('es_roleplay:freezePlayer', tonumber(args[2]), true)
					TriggerClientEvent('es_roleplay:cuff', -1, false, tonumber(args[2]))
					TriggerClientEvent('chatMessage', -1, "JAIL", {255, 140, 0}, " ^2" .. GetPlayerName(args[2]) .. "^0 a été mis en prison pendant ^2" .. tonumber(args[3]) .. " ^0minute(s). par ^2" .. GetPlayerName(source))
					
					SetTimeout(time, function()
										if(prisoners[args[2]])then
											TriggerClientEvent('es_roleplay:teleportPlayer', tonumber(args[2]), prison.exit.x, prison.exit.y, prison.exit.z)
											TriggerClientEvent('es_roleplay:freezePlayer', tonumber(args[2]), false)
											TriggerClientEvent('chatMessage', -1, "JAIL", {255, 140, 0}, " ^2" .. GetPlayerName(args[2]) .. "^0 a été relâché.")
										end
									end)
					
				end)
			else
				TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "ID joueur incorrect")
			end
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Pas la permission.")
end)

RegisterServerEvent("es_roleplay:playerDead")
AddEventHandler('es_roleplay:playerDead', function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
		if(target)then
			if(target.identifier)then
				if(cuffed)then
					cuffed[target.identifier] = nil
				end
			end
		end
	end)
end)

local cuffed = {}

TriggerEvent('es:addCommand', 'pipo', function(source, args, user)
	if(player_jobs[user.identifier] or (tonumber(user.permission_level) > 2))then
		local job = player_jobs[user.identifier]
		if(job)then
			job = player_jobs[user.identifier].job
		end

		if(groups.police[job] or tonumber(user.permission_level) > 2)then
			if(#args < 2)then
				TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Utilisation: ^2/jail (ID) (MINUTES)")
			else
				if(GetPlayerName(tonumber(args[2])))then
					TriggerEvent('es:getPlayerFromId', tonumber(args[2]), function(target)
						for k,v in pairs(prison.arrest)do
						if(get3DDistance(target.coords.x, target.coords.y, target.coords.z, v.x, v.y, v.z) < 10.0)then


									if(#args < 3)then
										TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Utilisation: ^2/jail (ID) (MINUTES)")
										return
									end

									prisoners[args[2]] = true

									local time = tonumber(args[3]) * 1000 * 60
									TriggerClientEvent('es_roleplay:teleportPlayer', tonumber(args[2]), prison.cam.x, prison.cam.y, prison.cam.z)
									TriggerClientEvent('es_roleplay:freezePlayer', tonumber(args[2]), true)
									TriggerClientEvent('police:cuffGranted', -1, false, tonumber(args[2]))
									TriggerClientEvent('chatMessage', -1, "JAIL", {255, 140, 0}, " ^2" .. GetPlayerName(args[2]) .. "^0 a été mis en prison pendant ^2" .. tonumber(args[3]) .. " ^0minute(s). By ^2" .. GetPlayerName(source))

									SetTimeout(time, function()
										if(prisoners[args[2]])then
											TriggerClientEvent('es_roleplay:teleportPlayer', tonumber(args[2]), prison.exit.x, prison.exit.y, prison.exit.z)
											TriggerClientEvent('es_roleplay:freezePlayer', tonumber(args[2]), false)
											TriggerClientEvent('chatMessage', -1, "JAIL", {255, 140, 0}, " ^2" .. GetPlayerName(args[2]) .. "^0 a été relâché.")
										end
									end)

							return
						else

						end
					end
					TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "La cible est trop loin du commissariat.")
					end)
				else
					TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "ID joueur incorrect")
				end
			end
		else
			TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Tu dois être policier.")
		end
	else
		TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Tu dois être policier.")
	end
end)

TriggerEvent('es:addCommand', 'cuff', function(source, args, user)
	if(player_jobs[user.identifier] or (tonumber(user.permission_level) > 2))then
		local job = player_jobs[user.identifier]
		if(job)then
			job = player_jobs[user.identifier].job
		end

		if(groups.police[job] or tonumber(user.permission_level) > 2)then
			if(#args < 2)then
				TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Utilisation: ^2/cuff (ID)")
			else
				if(GetPlayerName(tonumber(args[2])))then
					TriggerEvent('es:getPlayerFromId', tonumber(args[2]), function(target)
						if(get3DDistance(target.coords.x, target.coords.y, target.coords.z, user.coords.x, user.coords.y, user.coords.z) > 10.0)then
							TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Reste près du suspect.")
							return
						end

						if(cuffed[target.identifier])then
							cuffed[target.identifier] = not cuffed[target.identifier]
						else
							cuffed[target.identifier] = true
						end

						local state = ""
						if(cuffed[target.identifier])then
							state = "cuffed"
						else
							state = "uncuffed"
						end

						TriggerClientEvent('es_roleplay:cuff', -1, cuffed[target.identifier], tonumber(args[2]))
						TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, " ^2" .. GetPlayerName(tonumber(args[2])) .. "^0 a été " .. state .. ".")
						TriggerClientEvent('chatMessage', tonumber(args[2]), "JOB", {255, 0, 0}, "Tu as été " .. state .. " par ^2" .. GetPlayerName(source) .. "^0.")
					
						TriggerEvent("es_roleplay:playerCuffed", tonumber(args[2]), cuffed[target.identifier])
					end)
				else
					TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "ID joueur incorrect")
				end
			end
		else
			TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Tu dois être policier.")
		end
	else
		TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Tu dois être policier.")
	end
end)

-- Unseat
TriggerEvent('es:addCommand', 'unseat', function(source, args, user)
	if(player_jobs[user.identifier] or (tonumber(user.permission_level) > 2))then
		local job = player_jobs[user.identifier]
		if(job)then
			job = player_jobs[user.identifier].job
		end

		if(groups.police[job] or tonumber(user.permission_level) > 2)then
			if(#args < 2)then
				TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Utilisation: ^2/unseat (ID)")
			else
				if(GetPlayerName(tonumber(args[2])))then
					TriggerEvent('es:getPlayerFromId', tonumber(args[2]), function(target)
						if(get3DDistance(target.coords.x, target.coords.y, target.coords.z, user.coords.x, user.coords.y, user.coords.z) > 10.0)then
							TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Reste près du suspect.")
							return
						end

						if(not cuffed[target.identifier])then
							TriggerClientEvent('chatMessage', source, 'JOB', {255, 0, 0}, "La personne doit être menottée pour être sortie du véhicule.")
							return
						end

						TriggerClientEvent('es_roleplay:unseat', tonumber(args[2]), tonumber(args[2]))
						TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, " ^2" .. GetPlayerName(tonumber(args[2])) .. "^0 a été sorti du véhicule.")
						TriggerClientEvent('chatMessage', tonumber(args[2]), "JOB", {255, 0, 0}, "Tu as été sorti du véhicule par ^2" .. GetPlayerName(source) .. "^0.")
					end)
				else
					TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "ID joueur incorrect")
				end
			end
		else
			TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Tu dois être policier.")
		end
	else
		TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Tu dois être policier.")
	end
end)

-- Rcon commands
AddEventHandler('rconCommand', function(commandName, args)
    if commandName == 'unjail' then
			if #args ~= 1 then
					RconPrint("Usage: unjail [user-id]\n")
					CancelEvent()
					return
			end

			if(GetPlayerName(tonumber(args[1])) == nil)then
				RconPrint("Player not ingame\n")
				CancelEvent()
				return
			end

			if(prisoners[args[1]])then
				TriggerClientEvent('es_roleplay:teleportPlayer', tonumber(args[1]), prison.exit.x, prison.exit.y, prison.exit.z)
				TriggerClientEvent('es_roleplay:freezePlayer', tonumber(args[1]), false)
				TriggerClientEvent('chatMessage', -1, "CONSOLE", {0, 0, 0}, " ^2" .. GetPlayerName(args[1]) .. "^0 as été relâché de prison.")
				prisoners[args[1]] = nil
				RconPrint("Player unjailed\n")
			else
				RconPrint("Player is not in prison.\n")
			end

			CancelEvent()
		end
	end)