-- Loading MySQL Class
require "resources/essentialmode/lib/MySQL"
MySQL:open("localhost", "gta5_gamemode_essential", "root", "1202")

RegisterServerEvent('paycheck:salary')
AddEventHandler('paycheck:salary', function()
  	local salary = 1
	TriggerEvent('es:getPlayerFromId', source, function(user)
  	-- Ajout de l'argent à l'utilisateur
  	local user_id = user.identifier
  	-- Requête qui permet de recuperer le métier de l'utilisateur
  	local executed_query = MySQL:executeQuery("SELECT salary FROM users INNER JOIN jobs ON users.job = jobs.job_id WHERE identifier = '@username'",{['@username'] = user_id})
    local result = MySQL:getResults(executed_query, {'salary'})
    local salary_job = result[1].salary
  	user:addMoney((salary + salary_job))
 	TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "Salaire reçu :  + "..salary.."~g~€~s~~n~Salaire metier reçu : + "..salary_job.." ~g~€")
 	end)
end)
