---SCRIPT Mirardes-----

require "resources/essentialmode/lib/MySQL"
MySQL:open("localhost", "gta5_gamemode_essential", "root", "1202")

-- HELPER FUNCTIONS
function nameJob(player)
  local executed_query = MySQL:executeQuery("SELECT identifier, job_id, job_name FROM users LEFT JOIN jobs ON jobs.job_id = users.job WHERE users.identifier = '@identifier'", {['@identifier'] = player})
  local result = MySQL:getResults(executed_query, {'job_name'}, "identifier")
  return tostring(result[1].job_name)
end


-- V2
RegisterServerEvent('peche:bateau')

-- Pêche bateau
AddEventHandler('peche:bateau', function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local namejob = nameJob(player)
    -- NOM DU METIER
    if namejob == "Pecheur" then
      TriggerClientEvent('peche:bateau', source)
      TriggerClientEvent('worked', source)
    else
      TriggerClientEvent('notworked', source)
    end
  end)
end)

