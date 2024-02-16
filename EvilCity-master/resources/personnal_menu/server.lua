--
-- Created by IntelliJ IDEA.
-- User: Djyss
-- Date: 09/05/2017
-- Time: 09:55
-- To change this template use File | Settings | File Templates.
--

require "resources/essentialmode/lib/MySQL"
MySQL:open(database.host, database.name, database.username, database.password)

------------------------------------------------------------------------------------------------------------------------

-- get's the player id without having to use bugged essentials
function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end

-- gets the actual player id unique to the player,
-- independent of whether the player changes their screen name
function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end
------------------------------------------------------------------------------------------------------------------------

function checkNumber(number)
    local executed_query = MySQL:executeQuery("SELECT * FROM users WHERE phone_number = '@number' LIMIT 1", { ['@number'] = number })
    local result = MySQL:getResults(executed_query, { 'identifier','name'})
    if result then
        for _, v in ipairs(result) do
            return v
        end

    else
        return false
    end


end

RegisterServerEvent("pm:addNewNumero")
AddEventHandler("pm:addNewNumero", function(number)
    local player = getPlayerID(source)
    local contact =  checkNumber(number)
    if not contact then
        TriggerClientEvent("pm:notifs", source, "~o~Aucun contact trouvé")
    else
        local executed_query = MySQL:executeQuery("SELECT * FROM user_phonelist WHERE owner_id = '@username' AND contact_id = '@id' ", { ['@username'] = player, ['@id'] = contact.identifier })
        local result = MySQL:getResults(executed_query, { 'contact_id' })
        print(json.encode(result[1]))
        if(result[1] == nil) then
            MySQL:executeQuery("INSERT INTO user_phonelist (`owner_id`, `contact_id`) VALUES ('@owner', '@contact')",
                { ['@owner'] = player, ['@contact'] = contact.identifier })
            TriggerClientEvent("pm:notifs", source, "~g~Numéro de ~y~".. contact.name .. " ~g~ajouté" )
            updateRepertory({source = source, player = player })
        else
            TriggerClientEvent("pm:notifs", source, " ~y~".. contact.name .. "~r~ existe déjà dans votre répertoire" )
        end
    end
end)

RegisterServerEvent("pm:checkContactServer")
AddEventHandler("pm:checkContactServer", function(identifier)
    print(json.encode(identifier))
    local executed_query = MySQL:executeQuery("SELECT * FROM users WHERE identifier = '@id'", { ['@id'] = identifier.identifier })
    local result = MySQL:getResults(executed_query, { 'identifier', 'phone_number', 'name' })

    if result[1] ~= nil then
        for _, v in ipairs(result) do
            TriggerClientEvent("pm:notifs", source, "~o~".. v.name .. " : ~s~" .. v.phone_number)
        end
    end

end)




function updateRepertory(player)
    numberslist = {}
    source = player.source
    local player = player.player
    local executed_query = MySQL:executeQuery("SELECT * FROM user_phonelist JOIN users ON `user_phonelist`.`contact_id` = `users`.`identifier` WHERE owner_id = '@username' ORDER BY name ASC", { ['@username'] = player })
    local result = MySQL:getResults(executed_query, { 'identifier','name', 'contact_id'}, "contact_id")
    if (result) then
        for _, v in ipairs(result) do
            t = { name= v.name, identifier = v.identifier }
            table.insert(numberslist, v.identifier, t)
        end
    end
    TriggerClientEvent("pm:repertoryGetNumberListFromServer", source, numberslist)
end

local numberslist = {}
RegisterServerEvent("pm:repertoryGetNumberList")
AddEventHandler("pm:repertoryGetNumberList", function()
    numberslist = {}
    local player = getPlayerID(source)
    local executed_query = MySQL:executeQuery("SELECT * FROM user_phonelist JOIN users ON `user_phonelist`.`contact_id` = `users`.`identifier` WHERE owner_id = '@username' ORDER BY name ASC", { ['@username'] = player })
    local result = MySQL:getResults(executed_query, { 'identifier','name', 'contact_id'}, "contact_id")
    if (result) then
        for _, v in ipairs(result) do
            t = { name= v.name, identifier = v.identifier }
            table.insert(numberslist, v.identifier, t)
        end
    end
    TriggerClientEvent("pm:repertoryGetNumberListFromServer", source, numberslist)
end)

RegisterServerEvent("pm:sendNewMsg")
AddEventHandler("pm:sendNewMsg", function(msg)
    msg = {
        owner_id = getPlayerID(source),
        receiver = msg.receiver,
        msg = msg.msg
    }
    MySQL:executeQuery("INSERT INTO user_message (`owner_id`, `receiver_id`, `msg`, `has_read`) VALUES ('@owner', '@receiver', '@msg', '@read')",
        { ['@owner'] = msg.owner_id, ['@receiver'] = msg.receiver, ['@msg'] = msg.msg, ['@read'] = 0 })
    TriggerClientEvent("pm:notifs", source, " ~g~ message envoyé" )
end)

--local messagelist = {}
--RegisterServerEvent("pm:messageryGetOldMsg")
--AddEventHandler("pm:messageryGetOldMsg", function()
    --messagelist = {}
    --local player = getPlayerID(source)
    --local executed_query = MySQL:executeQuery("SELECT * FROM user_message JOIN users ON `user_message`.`owner_id` = `users`.`identifier` WHERE receiver_id = '@user'", { ['@user'] = player })
    --local result = MySQL:getResults(executed_query, { 'identifier', 'name', 'msg', 'date', 'has_read', 'owner_id', 'receiver_id'})
    --if (result) then
        --for _, val in ipairs(result) do
            --message = { msg = val.msg, name = val.name, identifier = val.identifier, date = tostring(val.date), has_read = val.has_read }
            ----table.insert(messagelist, val.identifier, message)
            --messagelist[_] = message
        --end
--
    --end
    --TriggerClientEvent("pm:messageryGetOldMsgFromServer", source, messagelist)
--end)
--
RegisterServerEvent("pm:setMsgReaded")
AddEventHandler("pm:setMsgReaded", function(msg)
    print(json.encode(msg))
    MySQL:executeQuery("UPDATE user_message SET `has_read` = 1 WHERE `receiver_id` = '@receiver' AND `msg` = '@msg' AND `has_read` = '@read' ", { ['@receiver'] = getPlayerID(source), ['@msg'] = msg.msg, ['@read'] = msg.has_read })
end)


------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("item:getItems")
RegisterServerEvent("item:updateQuantity")
RegisterServerEvent("item:setItem")
RegisterServerEvent("item:reset")
RegisterServerEvent("item:sell")
RegisterServerEvent("player:giveItem")
RegisterServerEvent("pm:wearHat")
RegisterServerEvent("pm:wearPercing")
RegisterServerEvent("pm:wearGlasses")
RegisterServerEvent("pm:wearMask")

local items = {}

AddEventHandler("item:getItems", function()
    items = {}
    local player = getPlayerID(source)
    local executed_query = MySQL:executeQuery("SELECT * FROM user_inventory JOIN items ON `user_inventory`.`item_id` = `items`.`id` WHERE user_id = '@username'", { ['@username'] = player })
    local result = MySQL:getResults(executed_query, { 'quantity', 'libelle', 'item_id' }, "item_id")
    if (result) then
        for _, v in ipairs(result) do
            t = { ["quantity"] = v.quantity, ["libelle"] = v.libelle }
            table.insert(items, tonumber(v.item_id), t)
        end
    end
    TriggerClientEvent("gui:getItems", source, items)
end)

AddEventHandler("item:setItem", function(item, quantity)
    local player = getPlayerID(source)
    MySQL:executeQuery("INSERT INTO user_inventory (`user_id`, `item_id`, `quantity`) VALUES ('@player', @item, @qty)",
        { ['@player'] = player, ['@item'] = item, ['@qty'] = quantity })
end)

AddEventHandler("item:updateQuantity", function(qty, id)
    local player = getPlayerID(source)
    MySQL:executeQuery("UPDATE user_inventory SET `quantity` = @qty WHERE `user_id` = '@username' AND `item_id` = @id", { ['@username'] = player, ['@qty'] = tonumber(qty), ['@id'] = tonumber(id) })
end)

AddEventHandler("item:reset", function()
    local player = getPlayerID(source)
    MySQL:executeQuery("UPDATE user_inventory SET `quantity` = @qty WHERE `user_id` = '@username'", { ['@username'] = player, ['@qty'] = 0 })
end)

AddEventHandler("item:sell", function(id, qty, price)
    TriggerEvent('es:getPlayerFromId', source, function(user)
        local player = user.identifier
        MySQL:executeQuery("UPDATE user_inventory SET `quantity` = @qty WHERE `user_id` = '@username' AND `item_id` = @id", { ['@username'] = player, ['@qty'] = tonumber(qty), ['@id'] = tonumber(id) })
        user:addMoney(tonumber(price))
    end)
end)

AddEventHandler("player:giveItem", function(item, name, qty, target)
    local player = getPlayerID(source)
    local executed_query = MySQL:executeQuery("SELECT SUM(quantity) as total FROM user_inventory WHERE user_id = '@username'", { ['@username'] = player })
    local result = MySQL:getResults(executed_query, { 'total' })
    local total = result[1].total
    if (total + qty <= 64) then
        TriggerClientEvent("player:looseItem", source, item, qty)
        TriggerClientEvent("player:receiveItem", target, item, qty)
        TriggerClientEvent("es_freeroam:notify", target, "CHAR_MP_STRIPCLUB_PR", 1, "Mairie", false, "Vous venez de recevoir " .. qty .. " " .. name)
    end
end)

------------------------------------------------------------------------------------------------------------------------
AddEventHandler("pm:wearHat", function()
    TriggerEvent('es:getPlayerFromId', source, function(user)
        local playerSkin_query = MySQL:executeQuery("SELECT * FROM skin WHERE identifier = '@username'", {['@username'] = user.identifier})
        local skin = MySQL:getResults(playerSkin_query, {'identifier','helmet', 'helmet_txt'}, "identifier")
        if(skin)then
            for k,v in ipairs(skin)do
                if v.helmet ~= nil then
                    TriggerClientEvent("pm:accessoriesWearHat", source, v)
                end
            end
        end
    end)
end)

AddEventHandler("pm:wearGlasses", function()
    TriggerEvent('es:getPlayerFromId', source, function(user)
        local playerSkin_query = MySQL:executeQuery("SELECT * FROM skin WHERE identifier = '@username'", {['@username'] = user.identifier})
        local skin = MySQL:getResults(playerSkin_query, {'identifier','glasses', 'glasses_txt'}, "identifier")
        if(skin)then
            for k,v in ipairs(skin)do
                if v.glasses ~= nil then
                    TriggerClientEvent("pm:accessoriesWearGlasses", source, v)
                end
            end
        end
    end)
end)

AddEventHandler("pm:wearPercing", function()
    TriggerEvent('es:getPlayerFromId', source, function(user)
        local playerSkin_query = MySQL:executeQuery("SELECT * FROM skin WHERE identifier = '@username'", {['@username'] = user.identifier})
        local skin = MySQL:getResults(playerSkin_query, {'identifier','percing', 'Percing_txt'}, "identifier")
        if(skin)then
            for k,v in ipairs(skin)do
                if v.percing ~= nil then
                    TriggerClientEvent("pm:accessoriesWearPercing", source, v)
                end
            end
        end
    end)
end)

AddEventHandler("pm:wearMask", function()
    TriggerEvent('es:getPlayerFromId', source, function(user)
        local playerSkin_query = MySQL:executeQuery("SELECT * FROM skin WHERE identifier = '@username'", {['@username'] = user.identifier})
        local skin = MySQL:getResults(playerSkin_query, {'identifier','mask', 'mask_txt'}, "identifier")
        if(skin)then
            for k,v in ipairs(skin)do
                if v.mask ~= nil then
                    TriggerClientEvent("pm:accessoriesWearMask", source, v)
                end
            end
        end
    end)
end)
------------------------------------------------------------------------------------------------------------------------
