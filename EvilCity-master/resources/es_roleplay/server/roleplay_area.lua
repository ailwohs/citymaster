local areas = uSettings.spawnAreas

game = {
	["currentArea"] = uSettings.defaultArea,
	["secondaryArea"] = nil
}

local spawned = {}

RegisterServerEvent('es_roleplay:spawn')
AddEventHandler('es_roleplay:spawn', function()
	if(not spawned[source])then
		spawned[source] = true
		uSettings.firstSpawned(source)

		TriggerEvent("es:getPlayerFromId", source, function(user)
			if(player_jobs[user.identifier])then
				if(jobs[player_jobs[user.identifier].job].onSpawn and not uSettings.loseJobOnDeath)then
					jobs[player_jobs[user.identifier].job].onSpawn(source, user)
				end

				if(uSettings.loseJobOnDeath)then
					TriggerClientEvent("es_jobs:setCurrentJob", source, "")
					local dName = player_jobs[user.identifier].job
					if(jobs[player_jobs[user.identifier].job].displayName)then
						dName = jobs[player_jobs[user.identifier].job].displayName
					end
					TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Tu as quitté: ^2" .. dName)

					if(jobs[player_jobs[user.identifier].job].onLeave)then
						jobs[player_jobs[user.identifier].job].onLeave(source, user)
					end

					if(jobs[player_jobs[user.identifier].job].skin)then
						TriggerClientEvent('es_admin:kill', source)
						TriggerEvent("es_customization:setToPlayerSkin", source)
					end

					if(not jobs[player_jobs[user.identifier].job].members)then
						jobs[player_jobs[user.identifier].job].members = {}
					end

					for k = 1,#jobs[player_jobs[user.identifier].job].members do
						if(jobs[player_jobs[user.identifier].job].members[k] == user.identifier)then
							table.remove(jobs[player_jobs[user.identifier].job].members, k)
						end
					end
					player_jobs[user.identifier] = nil

					TriggerEvent("es_weaponshop:getOwnedWeapons", source, function(weps)
						if(weps)then
							for k,v in weps do
								TriggerClientEvent('es_roleplay:giveWeapon', source, v)
							end
						end
					end)
				end
			end
		end)
	end
end)

RegisterServerEvent('es_roleplay:vehicleSiren')
AddEventHandler('es_roleplay:vehicleSiren', function(s)
	TriggerClientEvent('es_roleplay:vehicleSiren', -1, source, s)
end)

AddEventHandler('playerDropped', function()
	spawned[source] = false
end)

function MergeTable(t1, t2)
	local t = {}

	for k,v in ipairs(t1)do
		table.insert(t, v)
	end

	for k,v in ipairs(t2)do
		table.insert(t, v)
	end

	return t
end

RegisterServerEvent('es_roleplay:spawn')
AddEventHandler('es_roleplay:spawn', function()
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if(user)then
			TriggerClientEvent('es:activateMoney', source, user.money)
		end
	end)

	local pos = nil
	if(game.secondaryArea)then
		local spawns = MergeTable(game.currentArea.spawns, game.secondaryArea.spawns)
		pos = spawns[ math.random( #spawns ) ]
	else
		pos = game.currentArea.spawns[ math.random( #game.currentArea.spawns ) ]
	end

	local model = "mp_m_freemode_01"
	TriggerClientEvent('es_roleplay:spawnPlayer', source, pos.x, pos.y, pos.z, model)
end)

-- Change current spawn area
TriggerEvent('es:addAdminCommand', 'changearea', 5, function(source, args, user)
	table.remove(args, 1)
	local area = string.lower(table.concat(args, " "))

	if(areas[area])then
		TriggerClientEvent('chatMessage', -1, 'AREA', {255, 0, 0}, "Changing spawn area to: ^2" .. areas[area].name)
		game.currentArea = areas[area]
		game.secondaryArea = nil
	else
		TriggerClientEvent('chatMessage', source, "AREA", {255, 0, 0}, "Selected spawn area does not exist.")
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end)

-- Add second spawn area
TriggerEvent('es:addAdminCommand', 'secondaryarea', 5, function(source, args, user)
	table.remove(args, 1)
	local area = string.lower(table.concat(args, " "))

	if(areas[area])then
		if(areas[area].name == game.currentArea.name)then
			TriggerClientEvent('chatMessage', source, 'AREA', {255, 0, 0}, "Cannot set secondary spawn area to current area.")
		else
			TriggerClientEvent('chatMessage', -1, 'AREA', {255, 0, 0}, "Set secondary spawn area to: ^2" .. areas[area].name)
			game.secondaryArea = areas[area]
		end
	else
		TriggerClientEvent('chatMessage', source, "AREA", {255, 0, 0}, "Selected spawn area does not exist.")
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end)