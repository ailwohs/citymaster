Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)		
		if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
			local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			if DoesEntityExist(vehicle) and not IsEntityDead(vehicle) then
				if not HasStreamedTextureDictLoaded("speedo") then
					RequestStreamedTextureDict("speedo", true)
					while not HasStreamedTextureDictLoaded("speedo") do
						Wait(0)
					end
				else
					local degree = 0
					local step = 2.05833
					if GetEntitySpeed(vehicle) > 0 then degree=(GetEntitySpeed(vehicle)*2.236936)*step end
					DrawSprite("speedo", "speedom_003", 0.898,0.752,0.16,0.245, 0.0, 255, 255, 255, 255)
					if degree > 247 then degree=247 end
					DrawSprite("speedo", "needle_003", 0.898,0.755,0.116,0.15,43.00001+degree, 255, 255, 255, 200)
					if IsControlPressed(1, 216) then DrawSprite("speedo", "brakeson_001", 0.83,0.815,0.02,0.025, 0.0, 255, 255, 255, 150)
					else DrawSprite("speedo", "brakeson_002", 0.83,0.815,0.02,0.025, 0.0, 255, 255, 255, 150) end
					if IsVehicleInBurnout(vehicle) then DrawSprite("speedo", "burnout_002", 0.852,0.815,0.02,0.025, 0.0, 255, 255, 255, 150)
					else DrawSprite("speedo", "burnout_001", 0.852,0.815,0.02,0.025, 0.0, 255, 255, 255, 255)	end
					if IsVehicleStopped(vehicle) then DrawSprite("speedo", "park_002", 0.872,0.815,0.02,0.025, 0.0, 255, 255, 255, 150)
					else DrawSprite("speedo", "park_001", 0.872,0.815,0.02,0.025, 0.0, 255, 255, 255, 150) end
					if (GetVehicleEngineHealth(vehicle) > 0) and (GetVehicleEngineHealth(vehicle) > 300) then 
						DrawSprite("speedo", "engine_001", 0.892,0.815,0.02,0.025, 0.0, 255, 255, 255, 150)
					elseif GetVehicleEngineHealth(vehicle) < 1 then
						DrawSprite("speedo", "engine_003", 0.892,0.815,0.02,0.025, 0.0, 255, 255, 255, 150)
					else DrawSprite("speedo", "engine_002", 0.892,0.815,0.02,0.025, 0.0, 255, 255, 255, 150) end
				end
			end
		end
	end
end)