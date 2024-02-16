local voip = {}
voip['normal'] = {name = 'normal', setting = 30.0}
voip['chu'] = {name = 'chuchoter', setting = 3.0}
voip['cri'] = {name = 'crier', setting = 50.0}

AddEventHandler('onClientMapStart', function()
	NetworkSetTalkerProximity(voip['normal'].setting)
end)

RegisterNetEvent('pv:voip')
AddEventHandler('pv:voip', function(voipDistance)

	if voip[voipDistance]then
		distanceName = voip[voipDistance].name
		distanceSetting = voip[voipDistance].setting
	else
		distanceName = voip['normal'].name
		distanceSetting = voip['normal'].setting
	end
	
	NotificationMessage("Portée de voix régléé à ~b~" .. distanceName ..".")
	NetworkSetTalkerProximity(distanceSetting)
		
end)

function NotificationMessage(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0,1)
end