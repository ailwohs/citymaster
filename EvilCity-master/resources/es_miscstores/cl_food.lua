function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

--[[

	Coords for all shops
x=-46.313, y=-1757.504, z=29.421, a=46.395
x=24.376, y=-1345.558, z=29.421, a=267.940
x=1134.182, y=-982.477, z=46.416, a=275.432
x=373.015, y=328.332, z=103.566, a=257.309
x=2676.389, y=3280.362, z=55.241, a=332.305
x=1958.960, y=3741.979, z=32.344, a=303.196
x=-2966.391, y=391.324, z=15.043, a=88.867
x=-1698.542, y=4922.583, z=42.064, a=324.021
x=1164.565, y=-322.121, z=69.205, a=100.492
x=-1486.530, y=-377.768, z=40.163, a=147.669
x=-1221.568, y=-908.121, z=12.326, a=31.739
x=-706.153, y=-913.464, z=19.216, a=82.056
x=-1820.230, y=794.369, z=138.089, a=130.327
x=2555.474, y=380.909, z=108.623, a=355.737
x=1728.614, y=6416.729, z=35.037, a=247.369


]]

local function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline, center)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
	if(center)then
		Citizen.Trace("CENTER\n")
		SetTextCentre(false)
	end
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

local twentyfourseven_shops = {
	{ ['x'] = -2968.23, ['y'] = 391.287, ['z'] = 15.0433 },
	{ ['x'] = -1487.6, ['y'] = -379.241, ['z'] = 40.1634 },
	{ ['x'] = -1223.75, ['y'] = -906.757, ['z'] = 12.3264 },
	{ ['x'] = -708.498, ['y'] = -914.589, ['z'] = 19.2156 },
	{ ['x'] = 26.5477, ['y'] = -1347.68, ['z'] = 29.497 },
	{ ['x'] = -49.1843, ['y'] = -1757.32, ['z'] = 29.421 },
	{ ['x'] = 1136.35, ['y'] = -981.851, ['z'] = 46.4158 },
	{ ['x'] = 1162.75, ['y'] = -324.233, ['z'] = 69.2051 },
	{ ['x'] = 374.275, ['y'] = 326.384, ['z'] = 103.566 },
	{ ['x'] = 2679.35, ['y'] = 3280.89, ['z'] = 55.2411 },
	{ ['x'] = 1961.87, ['y'] = 3741, ['z'] = 32.3438 },
	{ ['x'] = 1698.31, ['y'] = 4925.44, ['z'] = 42.0637 },
}

local displayingBoughtMessage = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		if(displayingBoughtMessage)then
			Citizen.Wait(3000)
			displayingBoughtMessage = false
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if(displayingBoughtMessage)then
			DisplayHelpText("Tu as ~g~acheté~w~ et ~g~mangé~w~ un encas!")
		end

		local pos = GetEntityCoords(GetPlayerPed(-1), false)
		for k,v in ipairs(twentyfourseven_shops) do
			if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 20.0)then
				DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)

				if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 2.0)then
					if(GetEntityHealth(GetPlayerPed(-1)) < 200)then
						DisplayHelpText("Appuie sur ~INPUT_CONTEXT~ pour acheter un ~y~encas~w~ pour ~g~£30~w~ et te ~y~soigner~w~.")

						if(IsControlJustReleased(1, 51))then
							TriggerServerEvent('es_roleplay:buySnack', k)

							displayingBoughtMessage = true
						end
					else
						if(not displayingBoughtMessage)then
							DisplayHelpText("Tu n'as pas besoin de manger pour l'instant.")
						end
					end
				end
			end
		end
	end
end)