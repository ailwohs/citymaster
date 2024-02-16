AddEventHandler('playerSpawned', function(spawn)
	TriggerEvent("AwesomeGod", false)
    Citizen.CreateThread(function()
        Citizen.Wait(0) --run it
        for i = 0,31 do
            if NetworkIsPlayerConnected(i) then
                if NetworkIsPlayerConnected(i) and GetPlayerPed(i) ~= nil then
                    SetCanAttackFriendly(GetPlayerPed(i), true, true)
                    NetworkSetFriendlyFireOption(true)
                end                
            end
        end
    end)
end)