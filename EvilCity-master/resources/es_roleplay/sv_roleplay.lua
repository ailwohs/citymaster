local tags = uSettings.chatTags

-- Settings for EssentialMode
TriggerEvent("es:setDefaultSettings", {
	pvpEnabled = uSettings.pvpEnabled,
	debugInformation = false,
	startingCash = uSettings.startingMoney + 0.0,
	enableRankDecorators = true
})

function startswith(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

-- Default commands
TriggerEvent('es:addCommand', 'help', function(source, args, user)
	TriggerClientEvent("chatMessage", source, "HELP", {255, 0, 0}, "Commandes: ^2/job^0, ^2/jc^0, ^2/cuff^0, ^2/jail^0, ^2/police")
	TriggerClientEvent("chatMessage", source, "HELP", {255, 0, 0}, "Commandes: ^2/unseat^0, ^2/checkplate^0, ^2/general^0, ^2/me")
	TriggerClientEvent("chatMessage", source, "HELP", {255, 0, 0}, "Commandes: ^2/ts3^0, ^2/id")
end)

-- Default commands
TriggerEvent('es:addCommand', 'ts3', function(source, args, user)
	TriggerClientEvent("chatMessage", source, "HELP", {255, 0, 0}, "IP: ^3151.80.175.205 pass :brk")
end)

-- Default commands
TriggerEvent('es:addAdminCommand', 'delveh', 3, function(source, args, user)
	TriggerClientEvent("es_roleplay:deleteVehicle", source)
end, function(source, args, user)

end)

-- Default commands
TriggerEvent('es:addCommand', 'pay', function(source, args, user)
	local amount = args[2]

	if(#args < 2 or #args > 3)then
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Utilisation: ^2/pay (userid) (montant)")
		return
	end

	if(source == tonumber(args[2]))then
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Tu ne peux pas te donner de l'argent à toi même.")
		return
	end

	if(tonumber(args[3]) > 0 and tonumber(args[3]) <= user.money)then
		TriggerEvent('es:getPlayerFromId', tonumber(args[2]), function(target)

			if(target)then
				if(get3DDistance(user.coords.x, user.coords.y, user.coords.z, target.coords.x, target.coords.y, target.coords.z) < 6.0) then
					TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Payé a ^2" .. GetPlayerName(args[2]) .. ": ^3" .. args[3])
					TriggerClientEvent('chatMessage', tonumber(args[2]), "SYSTEM", {255, 0, 0}, "Reçu ^3" .. args[3] .. "^0 de ^2" .. GetPlayerName(source))
					
					user:removeMoney(tonumber(args[3]))
					target:addMoney(tonumber(args[3]))
				else
					TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Reste proche du joueur.")
				end
			else
				TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Le joueur n'existe pas.")
			end
		end)
	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Tu n'as pas cette somme ou tu as entré un montant négatif.")
	end
end)

-- Default commands
TriggerEvent('es:addCommand', 'ts', function(source, args, user)
	TriggerClientEvent("chatMessage", source, "HELP", {255, 0, 0}, "IP: ^1151.80.175.205 pass :brk")
end)

-- 911
TriggerEvent('es:addCommand', 'police', function(source, args, user)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local pos = user.coords
		table.remove(args, 1)
		local message = table.concat(args, " ")
		TriggerClientEvent('chatMessage', source, "POLICE", {255, 255, 0}, "" .. message)
		TriggerEvent('es:getPlayers', function(players)
		for id,_ in pairs(players) do
			if(GetPlayerName(id))then
				TriggerEvent('es:getPlayerFromId', id, function(target)
					local pPos = target.coords

					local range = get3DDistance(pos.x, pos.y, pos.z, pPos.x, pPos.y, pPos.z)

					local tag = ""
					for k,v in ipairs(tags)do
						if(user.permission_level >= v.rank)then
							tag = v.tag
						end
					end

					if(player_jobs[target['identifier']])then
						if(player_jobs[target['identifier']].job == "police" or player_jobs[target['identifier']].job == "ems" or player_jobs[target['identifier']].job == "fireman")then

							TriggerClientEvent('chatMessage', id, "POLICE", {255, 255, 0}, "" .. message)
						end
					end
				end)
			end
		end
	end)
	end)
end)

-- ME
TriggerEvent('es:addCommand', 'me', function(source, args, user)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local pos = user.coords

		table.remove(args, 1)
		local message = table.concat(args, " ")

		TriggerEvent('es:getPlayers', function(players)
		for id,_ in pairs(players) do
			if(GetPlayerName(id))then
				TriggerEvent('es:getPlayerFromId', id, function(target)
					local pPos = target.coords

					local range = get3DDistance(pos.x, pos.y, pos.z, pPos.x, pPos.y, pPos.z)

					local tag = ""
					for k,v in ipairs(tags)do
						if(user.permission_level >= v.rank)then
							tag = v.tag
						end
					end

					if(range < 30.0)then
						TriggerClientEvent('chatMessage', id, "", {0, 0, 200}, "^6* " .. GetPlayerName(source) .. " (^0"..source.."^6) " .. message)
					end
				end)
			end
		end
	end)
	end)
end)

-- ME
TriggerEvent('es:addCommand', 'id', function(source, args, user)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local pos = user.coords

		TriggerEvent('es:getPlayers', function(players)
		for id,_ in pairs(players) do
			if(GetPlayerName(id))then
				TriggerEvent('es:getPlayerFromId', id, function(target)
					local pPos = target.coords

					local range = get3DDistance(pos.x, pos.y, pos.z, pPos.x, pPos.y, pPos.z)

					local tag = ""
					for k,v in ipairs(tags)do
						if(user.permission_level >= v.rank)then
							tag = v.tag
						end
					end

					TriggerEvent("es_roleplay:getPlayerJob", user.identifier, function(job)
						local dJob = "None"
						if(job)then
							dJob = job.job .. " ^0(^2" .. job.id .. "^0)"
						end

						if(range < 10.0)then
							TriggerClientEvent('chatMessage', id, "", {0, 0, 200}, "^2" .. GetPlayerName(source) .. "'s ID")
							TriggerClientEvent('chatMessage', id, "", {0, 0, 200}, "Name: ^2" .. GetPlayerName(source) .. "")
							TriggerClientEvent('chatMessage', id, "", {0, 0, 200}, "Job: ^2" .. dJob)
						end

					end)
				end)
			end
		end
	end)
	end)
end)

-- DO
TriggerEvent('es:addCommand', 'do', function(source, args, user)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local pos = user.coords

		table.remove(args, 1)
		local message = table.concat(args, " ")

		TriggerEvent('es:getPlayers', function(players)
		for id,_ in pairs(players) do
			if(GetPlayerName(id))then
				TriggerEvent('es:getPlayerFromId', id, function(target)
					local pPos = target.coords

					local range = get3DDistance(pos.x, pos.y, pos.z, pPos.x, pPos.y, pPos.z)

					local tag = ""
					for k,v in ipairs(tags)do
						if(user.permission_level >= v.rank)then
							tag = v.tag
						end
					end

					if(range < 30.0)then
						TriggerClientEvent('chatMessage', id, "", {0, 0, 200}, "^6* " .. message .. " " .. GetPlayerName(source) .. " (^0"..source.."^6) ")
					end
				end)
			end
		end
	end)
	end)
end)

-- OOC
TriggerEvent('es:addCommand', 'general', function(source, args, user)
	table.remove(args, 1)
	local message = table.concat(args, " ")

	local tag = ""
	for k,v in ipairs(tags)do
		if(user.permission_level >= v.rank)then
			tag = v.tag
		end
	end

	TriggerClientEvent('chatMessage', -1, "GENERAL", {255, 0, 0}, tag .. "^4 " .. GetPlayerName(source) .. " ^4(^0"..source.."^4): ^0" .. message)
end)

AddEventHandler('chatMessage', function(source, n, message)
	if(not startswith(message, "/"))then
		CancelEvent()
		TriggerEvent('es:getPlayerFromId', source, function(user)
			local pos = user.coords

			TriggerEvent('es:getPlayers', function(players)
			for id,_ in pairs(players) do
				if(GetPlayerName(id))then
					TriggerEvent('es:getPlayerFromId', id, function(target)
						if(target)then
							local pPos = target.coords

							if(user.coords and target.coords)then
								local range = get3DDistance(pos.x, pos.y, pos.z, pPos.x, pPos.y, pPos.z)

								local tag = ""
								for k,v in ipairs(tags)do
									if(user.permission_level >= v.rank)then
										tag = v.tag
									end
								end

								if(range < 30.0)then
									TriggerClientEvent('chatMessage', id, "", {0, 0, 255}, tag .. "^4 " .. GetPlayerName(source) .. " ^4(^0"..source.."^4): ^0" .. message)
								end
							end
						end
					end)

				end
			end
			end)
		end)
	end
end)

AddEventHandler('es:invalidCommandHandler', function(source, args, user)
	TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Commande inconnue0, tape ^2/help^0 pour voir la liste.")
	CancelEvent()
end)