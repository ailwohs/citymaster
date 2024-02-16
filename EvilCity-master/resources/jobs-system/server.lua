require "resources/essentialmode/lib/MySQL"
MySQL:open("localhost", "gta5_gamemode_essential", "root", "1202")


function nameJob(id)
  local executed_query = MySQL:executeQuery("SELECT * FROM jobs WHERE job_id = '@namejob'", {['@namejob'] = id})
  local result = MySQL:getResults(executed_query, {'job_name'}, "job_id")
  return result[1].job_name
end

function updatejob(player, id)
  local job = id
  MySQL:executeQuery("UPDATE users SET `job`='@value' WHERE identifier = '@identifier'", {['@value'] = job, ['@identifier'] = player})
end

RegisterServerEvent('jobssystem:jobs')
AddEventHandler('jobssystem:jobs', function(id)
TriggerEvent('es:getPlayerFromId', source, function(user)
local player = user.identifier
local nameJob = nameJob(id)
updatejob(player, id)
TriggerClientEvent("es_freeroam:notify", source, "CHAR_MP_STRIPCLUB_PR", 1, "Mairie", false, "Votre métier est maintenant : ".. nameJob)
TriggerClientEvent("jobssystem:updateJob", source, nameJob)
end)
end)

AddEventHandler('es:playerLoaded', function(source)
TriggerEvent('es:getPlayerFromId', source, function(user)
local jobName = nameJob(source)
TriggerClientEvent("jobssystem:updateJob", source, jobName)
end)
end)

RegisterServerEvent('jobssystem:jobs')
AddEventHandler('jobssystem:jobs', function(id)
TriggerEvent('es:getPlayerFromId', source, function(user)
local player = user.identifier
local nameJob = nameJob(id)
updatejob(player, id)
TriggerClientEvent("es_freeroam:notify", source, "CHAR_MP_STRIPCLUB_PR", 1, "Mairie", false, "Votre métier est maintenant : ".. nameJob)
TriggerClientEvent("jobssystem:updateJob", source, nameJob)
end)
end)
function getJobId(identifier)
	local executed_query = MySQL:executeQuery("SELECT * FROM users WHERE identifier = '@name'", {['@name'] = identifier})
	local result = MySQL:getResults(executed_query, {'job'})
		return tonumber(result[1].job)
end

AddEventHandler('es:playerLoaded', function(source)
  TriggerEvent('es:getPlayerFromId', source, function(user)
  local jobId = getJobId(user.identifier)
  local jobName = nameJob(jobId)
  TriggerClientEvent("jobssystem:updateJob", source, jobName)
  end)
end)

function updatejob(player, id)
  local job = id
  MySQL:executeQuery("UPDATE users SET `job`='@value' WHERE identifier = '@identifier'", {['@value'] = job, ['@identifier'] = player})
  TriggerClientEvent("recolt:updateJobs", source, job)
end