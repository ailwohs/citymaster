---------------------------------- VAR ----------------------------------
local marqueursRecolte = {
  {name="Smoke on the water", colour=15, id=140, x=-1174.23, y=-1573.13, z=4.36979},
  --{name="Séchage du cannabis", colour=15, id=140, x=2460.11, y=3782.33, z=41.4795},
  --{name="Dealer de weed", colour=15, id=140, x=-1476.62, y=171.913, z=55.8878},
  {name="Mine de cuivre", colour=15, id=85, x=2647.44, y=2808.47, z=34.0299},
  {name="Fonderie", colour=15, id=85, x=1038.43, y=2261.32, z=43.7274},
  {name="Revente de cuivre", colour=15, id=85, x=172.353, y=2279.51, z=92.6733},
  {name="Vignes", colour=15, id=93, x=-1767.95, y=2201.6, z=102.744},
  {name="Distillerie", colour=15, id=93, x=840.893, y=-1952.84, z=28.8353},
  {name="Revente de l'alcool", colour=15, id=93, x=466.075, y=-1847.81, z=27.8526},
  --{name="Champ d'éphédrine", colour=15, id=51, x=2244.72, y=-2013.27, z=56.0862},
  --{name="Laboratoire de chimie", colour=15, id=51, x=1389.33, y=3604.11, z=38.9419},
  --{name="Revente de Meth", colour=15, id=51, x=129.38, y=-1939.28, z=20.6204},
  --{name="Champ de coca", colour=15, id=408, x=1926.17, y=4877.5, z=47.0778},
  --{name="Traitement de la coca", colour=15, id=408, x=-14.0969, y=-1434.14, z=31.1185},
  --{name="Revente de la cocaïne", colour=15, id=408, x=-1469.16, y=-925.772, z=10.09},
  {name="Récolte du bois", colour=15, id=444, x=-543.145, y=5103.37, z=115.352},
  {name="Découpe du bois", colour=15, id=444, x=-501.405, y=5280.53, z=80.0827},
  {name="Revente du bois 1", colour=15, id=444, x=1385.15, y=-601.138, z=73.8101},
  {name="Revente du bois 2", colour=15, id=444, x=79.5881, y=-432.285, z=37.553},
  --{name="Revente de cannabis 2", colour=15, id=140, x=-490.078, y=454.696, z=96.69541},
  --{name="Revente de Meth 2", colour=15, id=51, x=-42.0103, y=-1515.29, z=30.8352},
  --{name="Revente de la cocaïne 2", colour=15, id=408, x=-708.64, y=-880.558, z=23.6111},
  {name="Port pêcheur", id=404, x=1278.250, y=-3232.259, z=5.901},
  {name="Port pêcheur", id=404, x=1338.68, y=4225.48, z=33.9156},
  --{name="Pêche à la tortue", id=404, x=3273.41, y=46.2956, z=-0.6728},
  {name="Découpe de la tortue", id=404, x=-1200.81, y=-1769.06, z=3.8106},
  {name="Revente de viande de tortue 1", id=404, x=-1844.59, y=-1195.81, z=19.1856},
  {name="Revente de viande de tortue 2", id=404, x=-3249.09, y=1005.4, z=12.8307},
  {name="Pêche à la moule", id=404, x=364.891, y=3981.78, z=30.3177},
  {name="Revente de la moule", id=404, x=1958.33, y=3748.03, z=32.3438},
  {name="Commissariat Principal", id=60, x=94.137, y=-743.191, z=45.7554},
  {name="Hopital Sud-Est", id=61, x=1150.87, y=-1527.77, z=34.992},
  {name="Hopital Central", id=61, x=357.757, y=-597.202, z=28.6315},
}

local changeYourJob = {
  {name="Pole Emploi Sud", colour=15, id=351, x=-266.94, y=-960.744, z=31.2231},
  {name="Pole Emploi Centre", colour=15, id=351, x=591.826, y=2743.99, z=42.0382},
  {name="Pole Emploi Nord", colour=15, id=351, x=-405.57, y=6148.16, z=31.5321},
}

local jobs = {
	{name="Chomeur", id=2},
	{name="Mineur", id=3},
	{name="Chauffeur de taxi", id=4},
	{name="Vigneron", id=5},
	{name="Chauffeur poids lourd", id=6},
	{name="Dépanneur", id=7},
	{name="Pêcheur", id=8},
	{name="Bucheron", id=9},
	{name="Joaillier", id=13},
	{name="Ambulancier", id=15},
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
  for _, item in pairs(changeYourJob) do
    local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
    if(distance <= 10) then
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
    for _, item in pairs(changeYourJob) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
    end
end)

Citizen.CreateThread(function()
    for _, item in pairs(marqueursRecolte) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
    end
end)
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if (IsNearJobs() == true) then
      drawTxt('Appuyer sur ~g~H~s~ pour accéder au menu des métiers',0,1,0.5,0.8,0.6,255,255,255,255)
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