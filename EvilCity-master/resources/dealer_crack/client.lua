
local changeYourJobCrack = {
  {name="Pole Emploi", colour=15, id=351, x=-277.931, y=-778.196, z=50.837},
}

local jobs = {
	{name="Dealer de Crack", id=14},
}

---------------------------------- FUNCTIONS ----------------------------------

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
  SetTextFont(font)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0,255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(centre)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x , y)
end

function IsNearJobs()
  local ply = GetPlayerPed(-1)
  local plyCoords = GetEntityCoords(ply, 0)
  for _, item in pairs(changeYourJobCrack) do
    local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
    if(distance <= 4) then
      return true
    end
  end
end

function menuJobs()
  MenuTitle = "Jobs"
  ClearMenu()
  for _, item in pairs(jobs) do
    local nameJob = item.name
    local idJob = item.id
    Menu.addButton(nameJob,"changeJob",idJob)
  end
end

function changeJob(id)
  TriggerServerEvent("jobssystem:jobs", id)
end

---------------------------------- CITIZEN ----------------------------------


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if (IsNearJobs() == true) then
      drawTxt('Appuyer sur ~g~H~s~ pour devenir dealer',0,1,0.5,0.8,0.6,255,255,255,255)
    if (IsControlJustPressed(1,Keys["H"]) and IsNearJobs() == true) then
      menuJobs()
      Menu.hidden = not Menu.hidden 
    end
  end
    Menu.renderGUI()
  end
end)

RegisterNetEvent('jobssystem:updateJob')
AddEventHandler('jobssystem:updateJob', function(nameJob)
local id = PlayerId()
local playerName = GetPlayerName(id)
SendNUIMessage({
updateJob = true,
job = nameJob,
player = playerName
})
end)