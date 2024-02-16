TriggerServerEvent("Z:newplayer")

timeLeft = 300

RegisterNetEvent("Z:adverthost") AddEventHandler("Z:adverthost", function()  

	Citizen.CreateThread(function()
		while true do 
			Wait(1000)
			timeLeft = timeLeft - 1
			TriggerServerEvent("Z:timeleftsync", timeLeft) 
				
				if timeLeft < 1 then
							timeLeft = 300
			end 
		end
	end)
end)