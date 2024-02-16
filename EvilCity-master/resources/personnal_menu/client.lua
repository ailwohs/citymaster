--
-- Created by IntelliJ IDEA.
-- User: Djyss
-- Date: 09/05/2017
-- Time: 09:55
-- To change this template use File | Settings | File Templates.
--




local options = {
    x = 0.1,
    y = 0.2,
    width = 0.2,
    height = 0.04,
    scale = 0.4,
    font = 0,
    menu_title = "Menu personnel",
    menu_subtitle = "Categories",
    color_r = 192,
    color_g = 57,
    color_b = 43,
}


------------------------------------------------------------------------------------------------------------------------

-- Base du menu
function PersonnalMenu()
    ped = GetPlayerPed(-1);
    ClearMenu()
    Menu.addButton("Animations", "animsMenu", nil)
    -----Menu.addButton("Telephone", "phoneMenu", nil)
    Menu.addButton("Inventaire", "inventoryMenu", nil)
    ---Menu.addButton("Gestion des accessoires", "accessoriesMenu", nil)
    ---Menu.addButton("Montrer ma carte d'identité", "showCardMenu", nil)
    ---Menu.addButton("Ma carte d'identité", "myCardMenu", nil)
    ----Menu.addButton("Donner de l argent", "moneyMenu", nil)
end

------------------------------------------------------------------------------------------------------------------------

--NUMBERS_LIST = {}
--OLDS_MSG = {}
--AddEventHandler("playerSpawned", function()
    --TriggerServerEvent("pm:repertoryGetNumberList")
  --  TriggerServerEvent("pm:messageryGetOldMsg")
--end)

--Citizen.CreateThread(function()
    --while true do
    --    Wait(30000)
  --      TriggerServerEvent("pm:messageryGetOldMsg")
    --end
--end)

-- handles when a player spawns either from joining or after death
RegisterNetEvent("pm:repertoryGetNumberListFromServer")
AddEventHandler("pm:repertoryGetNumberListFromServer", function(NUMBERSLIST)
    NUMBERS_LIST = {}
    NUMBERS_LIST = NUMBERSLIST
end)

-- handles when a player spawns either from joining or after death
RegisterNetEvent("pm:notifs")
AddEventHandler("pm:notifs", function(msg)
    notifs(msg)
end)

function notifs(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString( msg )
    DrawNotification(false, false)
end

-- handles when a player spawns either from joining or after death
--RegisterNetEvent("pm:messageryGetOldMsgFromServer")
--AddEventHandler("pm:messageryGetOldMsgFromServer", function(OLDSMSG)
    --OLDS_MSG = {}
    --OLDS_MSG = OLDSMSG
--end)

-- Menu du téléphone

function phoneMenu()
    options.menu_subtitle = "Telephone"
    ClearMenu()
    Menu.addButton("Ajouter un numero", "newNumero", nil )
    Menu.addButton("Repertoire", "repertoryMenu", nil )
    Menu.addButton("Messagerie", "messageryMenu", nil )
    Menu.addButton("Prendre une photo", "takePhoto", nil )
    Menu.addButton("Retour", "PersonnalMenu", nil )
end

function newNumero()
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 10)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        TriggerServerEvent("pm:addNewNumero", result)
        phoneMenu()
    end
end

function repertoryMenu()
    options.menu_subtitle = "Repertoire"
    ClearMenu()
    Menu.addButton("Appeler la police", "callPolice")
    for ind, value in pairs(NUMBERS_LIST) do
        Menu.addButton(value.name, "repertoryContact", value.identifier)
    end
    Menu.addButton("Retour", "phoneMenu", nil )
end

function callPolice()
end

function repertoryContact(contact)
    options.menu_subtitle = "Repertoire"
    ClearMenu()
    Menu.addButton("Afficher le numéro", "checkContact", contact )
    Menu.addButton("Envoyer un message", "writeMsg", contact )
    Menu.addButton("Retour", "phoneMenu", nil )

end

function checkContact(contact)
    Citizen.Trace("DEBUG: "..contact)
    TriggerServerEvent("pm:checkContactServer", {identifier = contact})
end

function writeMsg(receiver)

    DisplayOnscreenKeyboard(6, "FMMC_KEY_TIP8", "(120 characters max)", "", "", "", "", 120)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        local msg = {
            receiver = receiver,
            msg = result
        }
        TriggerServerEvent("pm:sendNewMsg", msg)
        phoneMenu()
    end
end

function messageryMenu()
    options.menu_subtitle = "Messagerie"
    ClearMenu()
    for ind, value in pairs(OLDS_MSG) do
        local n = ""
        if value.has_read == 0 then
            n = " - ~r~Non lu"
            notifs("~o~ Vous avez des nouveaux message non lus !")
        end
        Menu.addButton(value.name .. " " .. n, "readOldMsg", {msg = value.msg, name = value.name, date= value.date, has_read = value.has_read, receiver_id = value.receiver_id})
    end
    Menu.addButton("Retour", "phoneMenu", nil )
end

function readOldMsg(msg)
    if msg.has_read == 0 then
        TriggerServerEvent("pm:setMsgReaded", msg)
    end
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg.msg)
    SetNotificationMessage("CHAR_ALL_PLAYERS_CONF", "CHAR_ALL_PLAYERS_CONF", true, 1, msg.name , "Le ("..tostring(msg.date)..")" , "Message reçu")
    DrawNotification(false, true)
    messageryMenu()
end

function takePhoto()
    RequestAnimDict( "cellphone@" )
    while not HasAnimDictLoaded( "cellphone@" ) do
        Citizen.Wait(0)
    end
    if HasAnimDictLoaded( "cellphone@" ) then
        TaskPlayAnim( PlayerPedId(), "cellphone@" , "cellphone_photo_idle" ,8.0, -8.0, -1, 0, 0, false, false, false )
    end
end

------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPedUsingAnyScenario(GetPlayerPed(-1)) then
            if IsControlJustPressed(1, 34) or IsControlJustPressed(1, 32) or IsControlJustPressed(1, 8) or IsControlJustPressed(1, 9) then
                ClearPedTasks(GetPlayerPed(-1))
            end
        end

    end
end)

-- Menu des animations
function animsMenu()
    options.menu_subtitle = "Animations"
    ClearMenu()
    Menu.addButton("lever les bras", "animsAction", { lib = "ped", anim = "handsup" })
    Menu.addButton("Saluer", "animsSalute", nil)
    Menu.addButton("Humeur", "animsHumor", nil)
    Menu.addButton("Sportives", "animsSportives",nil)
    Menu.addButton("Festives", "animsFestives",nil)
    Menu.addButton("Autres", "animsOthers", nil)
    --Menu.addButton("Placer obj test", "animsWithModelsSpawn", {object = "prop_roadcone02c"})
    Menu.addButton("Retour","PersonnalMenu",nil)
end

function animsSportives()
    options.menu_subtitle = "Animations  Sportives"
    ClearMenu()
    Menu.addButton("Faire du Yoga", "animsActionScenario", { anim = "WORLD_HUMAN_YOGA" })
    Menu.addButton("Jogging", "animsActionScenario", { anim = "WORLD_HUMAN_JOG_STANDING" })
    Menu.addButton("Faire des pompes", "animsActionScenario", { anim = "WORLD_HUMAN_PUSH_UPS" })
    Menu.addButton("Retour","animsMenu",nil)
end

function animsFestives()
    options.menu_subtitle = "Animations  Festives"
    ClearMenu()
    Menu.addButton("Boire une biere", "animsActionScenario", { anim = "WORLD_HUMAN_DRINKING" })
    Menu.addButton("Pres du feu", "animsActionScenario", { anim = "WORLD_HUMAN_STAND_FIRE" })
    Menu.addButton("Jouer de la musique", "animsActionScenario", {anim = "WORLD_HUMAN_MUSICIAN" })
    Menu.addButton("Retour","animsMenu",nil)
end

function animsSalute()
    options.menu_subtitle = "Animations  Saluer"
    ClearMenu()
    Menu.addButton("Serrer la main", "animsAction", { lib = "mp_common", anim = "givetake1_a" })
    Menu.addButton("Dire bonjour", "animsAction", { lib = "gestures@m@standing@casual", anim = "gesture_hello" })
    Menu.addButton("Tappes moi en 5", "animsAction", { lib = "mp_ped_interaction", anim = "highfive_guy_a" })
    Menu.addButton("Salut militaire", "animsAction", { lib = "mp_player_int_uppersalute", anim = "mp_player_int_salute" })
    Menu.addButton("Retour","animsMenu",nil)
end

function animsHumor()
    options.menu_subtitle = "Animations  Humeur"
    ClearMenu()
    Menu.addButton("Feliciter", "animsActionScenario", {anim = "WORLD_HUMAN_CHEERING" })
    Menu.addButton("Branleur", "animsAction", { lib = "mp_player_int_upperwank", anim = "mp_player_int_wank_01" })
    Menu.addButton("Dammed ", "animsAction", { lib = "gestures@m@standing@casual", anim = "gesture_damn" })
    Menu.addButton("Calme toi ", "animsAction", { lib = "gestures@m@standing@casual", anim = "gesture_easy_now" })
    Menu.addButton("No way", "animsAction", { lib = "gestures@m@standing@casual", anim = "gesture_no_way" })
    Menu.addButton("Fuck", "animsAction", { lib = "mp_player_int_upperfinger", anim = "mp_player_int_finger_01_enter" })
    Menu.addButton("Doigt d'honneur", "animsAction", { lib = "mp_player_int_upperfinger", anim = "mp_player_int_finger_01_enter" })
    Menu.addButton("Balle dans la tete", "animsAction", { lib = "mp_suicide", anim = "pistol" })
    Menu.addButton("Super", "animsAction", { lib = "mp_action", anim = "thanks_male_06" })
    Menu.addButton("Enlacer", "animsAction", { lib = "mp_ped_interaction", anim = "kisses_guy_a" })
    Menu.addButton("Retour","animsMenu",nil)
end

function animsOthers()
    options.menu_subtitle = "Animations  Autres"
    ClearMenu()
    Menu.addButton("Réparer le véhicule", "animsActionScenario", { anim = "WORLD_HUMAN_WELDING" })
    Menu.addButton("Prendre des notes", "animsActionScenario", { anim = "WORLD_HUMAN_CLIPBOARD" })
    Menu.addButton("S'assoir", "animsActionScenario", { anim = "WORLD_HUMAN_PICNIC" })
    Menu.addButton("Fumer une clope", "animsActionScenario", { anim = "WORLD_HUMAN_SMOKING" })
    --Menu.addButton("Reparer le moteur", "animsAction", { lib = "amb@world_human_vehicle_mechanic@male@idle_a", anim = "WORLD_HUMAN_VEHICLE_MECHANIC" })
    Menu.addButton("Se gratter les c**", "animsAction", { lib = "mp_player_int_uppergrab_crotch", anim = "mp_player_int_grab_crotch" })
    Menu.addButton("Rock and Roll", "animsAction", { lib = "mp_player_int_upperrock", anim = "mp_player_int_rock" })
    Menu.addButton("Retour","animsMenu",nil)

end

function animsAction(animObj)
    RequestAnimDict( animObj.lib )
    while not HasAnimDictLoaded( animObj.lib ) do
        Citizen.Wait(0)
    end
    if HasAnimDictLoaded( animObj.lib ) then
        TaskPlayAnim( GetPlayerPed(-1), animObj.lib , animObj.anim ,8.0, -8.0, -1, 0, 0, false, false, false )
    end
end

function animsActionScenario(animObj)
    local ped = GetPlayerPed(-1);

    if ped then
        local pos = GetEntityCoords(ped);
        local head = GetEntityHeading(ped);
        --TaskStartScenarioAtPosition(ped, animObj.anim, pos['x'], pos['y'], pos['z'] - 1, head, -1, false, false);
        TaskStartScenarioInPlace(ped, animObj.anim, 0, false)
        if IsControlJustPressed(1,188) then
        end

    end
end

function animsWithModelsSpawn(object)

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))

    RequestModel(object.object)
    while not HasModelLoaded(object.object) do
        Wait(1)
    end

    local object = CreateObject(object.object, x, y+2, z, true, true, true)
    -- local vX, vY, vZ = table.unpack(GetEntityCoords(object,  true))

    -- AttachEntityToEntity(object, PlayerId(), GetPedBoneIndex(PlayerId()), vX,  vY,  vZ, -90.0, 0, -90.0, true, true, true, false, 0, true)
    PlaceObjectOnGroundProperly(object) -- This function doesn't seem to work.

end

------------------------------------------------------------------------------------------------------------------------

-- register events, only needs to be done once
RegisterNetEvent("item:reset")
RegisterNetEvent("item:getItems")
RegisterNetEvent("item:updateQuantity")
RegisterNetEvent("item:setItem")
RegisterNetEvent("item:sell")
RegisterNetEvent("gui:getItems")
RegisterNetEvent("player:receiveItem")
RegisterNetEvent("player:looseItem")
RegisterNetEvent("player:sellItem")

ITEMS = {}
local playerdead = false
local maxCapacity = 80

-- handles when a player spawns either from joining or after death
AddEventHandler("playerSpawned", function()
    TriggerServerEvent("item:getItems")
    -- reset player dead flag
    playerdead = false
end)

AddEventHandler("gui:getItems", function(THEITEMS)
    ITEMS = {}
    ITEMS = THEITEMS
end)

AddEventHandler("player:receiveItem", function(item, quantity)
    if (inventoryGetPods() + quantity <= maxCapacity) then
        item = tonumber(item)
        if (ITEMS[item] == nil) then
            inventoryNew(item, quantity)
        else
            inventoryAdd({ item, quantity })
        end
    end
end)

AddEventHandler("player:looseItem", function(item, quantity)
    item = tonumber(item)
    if (ITEMS[item].quantity >= quantity) then
        inventoryDelete({ item, quantity })
    end
end)

AddEventHandler("player:sellItem", function(item, price)
    item = tonumber(item)
    if (ITEMS[item].quantity > 0) then
        inventorySell({ item, price })
    end
end)

-- Menu de l'inventaire
function inventoryMenu()
    ped = GetPlayerPed(-1);
    options.menu_subtitle = "Items  "
    options.rightText = (inventoryGetPods() or 0) .. "/" .. maxCapacity
    ClearMenu()
    for ind, value in pairs(ITEMS) do
        if (value.quantity > 0) then
            Menu.addButton(tostring(value.quantity) .. " " ..tostring(value.libelle), "inventoryItemMenu", ind)
        end
    end
    Menu.addButton("Retour", "PersonnalMenu", ind)
end

function inventoryItemMenu(itemId)
    ClearMenu()
    options.menu_subtitle = "Details "
    --Menu.addButton("Donner", "give", itemId)
    Menu.addButton("Utiliser", "use", itemId)
end

--function inventoryGive(item)
  --  local player = getNearPlayer()
    --if (player ~= nil) then
      --  DisplayOnscreenKeyboard(1, "Quantité :", "", "", "", "", "", 2)
        --while (UpdateOnscreenKeyboard() == 0) do
          --  DisableAllControlActions(0);
            --Wait(0);
        --end
        --if (GetOnscreenKeyboardResult()) then
            --local res = tonumber(GetOnscreenKeyboardResult())
            --if (ITEMS[item].quantity - res >= 0) then
                --TriggerServerEvent("player:giveItem", item, ITEMS[item].libelle, res, GetPlayerServerId(player))
            --end
        --end
    --end
--end

function use(item)
    if (ITEMS[item].quantity - 1 >= 0) then
        -- Nice var swap for nothing
        TriggerEvent("player:looseItem", item, 1)
        TriggerServerEvent("item:updateQuantity", 1, item)
        -- Calling the Hunger/Thirst
        if ITEMS[item].type == 2 then
            TriggerEvent("food:eat", ITEMS[item])
        elseif ITEMS[item].type == 1 then
            TriggerEvent("food:drink", ITEMS[item])
        else
            -- Any other type? Drugs??????
            Toxicated()
            Citizen.Wait(7000)
            ClearPedTasks(GetPlayerPed(-1))
            Reality()
        end
    end
end

function inventorySell(arg)
    local itemId = tonumber(arg[1])
    local price = arg[2]
    local item = ITEMS[itemId]
    item.quantity = item.quantity - 1
    TriggerServerEvent("item:sell", itemId, item.quantity, price)
    inventoryMenu()
end

function inventoryDelete(arg)
    local itemId = tonumber(arg[1])
    local qty = arg[2]
    local item = ITEMS[itemId]
    item.quantity = item.quantity - qty
    TriggerServerEvent("item:updateQuantity", item.quantity, itemId)
    inventoryMenu()
end

function inventoryAdd(arg)
    local itemId = tonumber(arg[1])
    local qty = arg[2]
    local item = ITEMS[itemId]
    item.quantity = item.quantity + qty
    TriggerServerEvent("item:updateQuantity", item.quantity, itemId)
    InventoryMenu()
end

function inventoryNew(item, quantity)
    TriggerServerEvent("item:setItem", item, quantity)
    TriggerServerEvent("item:getItems")
end

function inventoryGetQuantity(itemId)
    return ITEMS[tonumber(itemId)].quantity
end

function inventoryGetPods()
    local pods = 0
    for _, v in pairs(ITEMS) do
        pods = pods + v.quantity
    end
    return pods
end

function notFull()
    if (inventoryGetPods() < maxCapacity) then return true end
end

function PlayerIsDead()
    -- do not run if already ran
    if playerdead then
        return
    end
    TriggerServerEvent("item:reset")
end

function getPlayers()
    local playerList = {}
    for i = 0, 32 do
        local player = GetPlayerFromServerId(i)
        if NetworkIsPlayerActive(player) then
            table.insert(playerList, player)
        end
    end
    return playerList
end

function getNearPlayer()
    local players = getPlayers()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local pos2
    local distance
    local minDistance = 3
    local playerNear
    for _, player in pairs(players) do
        pos2 = GetEntityCoords(GetPlayerPed(player))
        distance = GetDistanceBetweenCoords(pos["x"], pos["y"], pos["z"], pos2["x"], pos2["y"], pos2["z"], true)
        if (pos ~= pos2 and distance < minDistance) then
            playerNear = player
            minDistance = distance
        end
    end
    if (minDistance < 3) then
        return playerNear
    end
end

------------------------------------------------------------------------------------------------------------------------
wearingHat = true
wearingGlasses = true
wearingPercing = true
wearingMask = true
-- Menu Accessoires
function accessoriesMenu()
    options.menu_subtitle = "Accessoires"
    ClearMenu()
    Menu.addButton("Porter ou Retirer chapeaux", "accessoriesWearHatChecker")
    Menu.addButton("Porter ou Retirer lunette", "accessoriesWearGlassesChecker")
    Menu.addButton("Porter ou Retirer percing", "accessoriesWearPercingChecker")
    Menu.addButton("Porter ou Retirer cagoule/mask", "accessoriesWearMaskChecker")
    Menu.addButton("Retour","PersonnalMenu",nil)
end

RegisterNetEvent("pm:accessoriesWearHat")
AddEventHandler("pm:accessoriesWearHat", function(item)
    SetPedPropIndex(GetPlayerPed(-1), 0, item.helmet,item.helmet_txt, 0)
end)
function accessoriesWearHatChecker()
    if wearingHat then
        wearingHat = false
        ClearPedProp(GetPlayerPed(-1),0)
    else
        wearingHat = true
        TriggerServerEvent("pm:wearHat")
    end

end

RegisterNetEvent("pm:accessoriesWearPercing")
AddEventHandler("pm:accessoriesWearPercing", function(item)
    SetPedPropIndex(GetPlayerPed(-1), 2, item.percing,item.percing_txt, 0)
end)
function accessoriesWearPercingChecker()
    if wearingGlasses then
        wearingGlasses = false
        ClearPedProp(GetPlayerPed(-1),2)
    else
        wearingGlasses = true
        TriggerServerEvent("pm:wearPercing")
    end

end

RegisterNetEvent("pm:accessoriesWearGlasses")
AddEventHandler("pm:accessoriesWearGlasses", function(item)
    SetPedPropIndex(GetPlayerPed(-1), 1, item.glasses,item.glasses_txt, 0)
end)
function accessoriesWearGlassesChecker()
    if wearingPercing then
        wearingPercing = false
        ClearPedProp(GetPlayerPed(-1),1)
    else
        wearingPercing = true
        TriggerServerEvent("pm:wearGlasses")
    end

end

RegisterNetEvent("pm:accessoriesWearMask")
AddEventHandler("pm:accessoriesWearMask", function(item)
    SetPedComponentVariation(GetPlayerPed(-1), 1, item.mask,item.mask_txt, 0)
end)
function accessoriesWearMaskChecker()
    if wearingMask then
        wearingMask = false
        SetPedComponentVariation(GetPlayerPed(-1), 1, 0, 0)
    else
        wearingMask = true
        TriggerServerEvent("pm:wearMask")
    end

end

------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if(not IsPedInAnyVehicle(GetPlayerPed(-1), false))then
        if IsControlJustPressed(1, 311) then
            PersonnalMenu() -- Menu to draw
            Menu.hidden = not Menu.hidden -- Hide/Show the menu
        end
        Menu.renderGUI(options) -- Draw menu on each tick if Menu.hidden = false
        if IsEntityDead(PlayerPedId()) then
            PlayerIsDead()
            -- prevent the death check from overloading the server
            playerdead = true
			else
			end
        end
    end
end)

------------------------------------------------------------------------------------------------------------------------
