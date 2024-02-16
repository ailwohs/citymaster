--Private Messages
TriggerEvent('es:addCommand', 'w', function(source, args, user)
if(GetPlayerName(tonumber(args[2])) or GetPlayerName(tonumber(args[3])))then
local player = tonumber(args[2])
table.remove(args, 2)
table.remove(args, 1)

TriggerEvent("es:getPlayerFromId", player, function(target)
TriggerClientEvent('chatMessage', player, "Message privé reçu de", {214, 214, 214}, "^2"..GetPlayerName(source).. " | " .. player .. " | MP: ^7" ..table.concat(args, " "))
TriggerClientEvent('chatMessage', source, "MP", {214, 214, 214}, "^3 Envoyé à: "..GetPlayerName(player).. ": ^7" ..table.concat(args, " "))
end)
else
TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "ID joueur incorrect!")
end
end, function(source, args, user)
TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Pas la permission!")
end)