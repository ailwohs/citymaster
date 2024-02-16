RegisterServerEvent("getInteriors")

require "resources/essentialmode/lib/MySQL"
MySQL:open("127.0.0.1", "gta5_gamemode_essential", "root", "1202")

function mysql_load_interiors()
	local executed_query = MySQL:executeQuery("SELECT * FROM interiors WHERE 1 = @where", {['@where'] = "1"})
	local result = MySQL:getResults(executed_query, {'id','enter','exit','iname'}, "id")
	local ints = {}
	if result ~= nil then
		for i=1,#result do
			local t = table.pack(result[i]['id'],json.decode(result[i]['enter']),json.decode(result[i]['exit']),result[i]['iname'])
			table.insert(ints, t)
		end
		return ints
	end
end

AddEventHandler('getInteriors', function()
	local to_player = mysql_load_interiors()
	if to_player ~= nil then TriggerClientEvent('sendInteriors', source, to_player) end
end)