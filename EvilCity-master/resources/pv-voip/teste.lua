TriggerEvent('es:addCommand', 'v', function(source, args, user)

	TriggerClientEvent('pv:voip', source, args[2])

end)