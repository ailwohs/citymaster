players = {}
host = nil
local adverts = {
	"Site: http://www.teambrk.com .",
	"Teamspeak: 151.80.175.205 pass: brk."
}
local nextadvert = 1

RegisterServerEvent("Z:newplayer")
AddEventHandler("Z:newplayer", function()
    players[source] = true

    if not host then
        host = source
        TriggerClientEvent("Z:adverthost", source)
    end
end)

AddEventHandler("playerDropped", function(reason)
    players[source] = nil

    if source == host then
        if #players > 0 then
            for mSource, _ in pairs(players) do
                host = mSource
                TriggerClientEvent("Z:adverthost", source)
                break
            end
        else
            host = nil
        end
    end
end)

RegisterServerEvent("Z:timeleftsync")
AddEventHandler("Z:timeleftsync", function(nTimeLeft)
	timeLeft = nTimeLeft
    if timeLeft < 1 then
	   
      TriggerClientEvent("chatMessage", -1, "^1NOTE", {255, 255, 255}, adverts[nextadvert])
	  nextadvert = nextadvert + 1
	  
	  if nextadvert == 8 then
		nextadvert = 1
	  end
    end
end)
