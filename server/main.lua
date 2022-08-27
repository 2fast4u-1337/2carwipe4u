local QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand(Config.Cmd, function(source, args, rawCommand) 
	if Config.QBCore then
		local player = QBCore.Functions.GetPlayer(source)
	  	local playerGroup = player.getGroup()

	 	if playerGroup ~= nil and playerGroup == "superadmin" or playerGroup == "admin" or playerGroup == "mod" or source <= 0 then 
	      	TriggerClientEvent('DelVehicles:delete', -1)
	  	end
	else
		for i, a in ipairs(Config.AdminList) do
	        for x, b in ipairs(GetPlayerIdentifiers(source)) do
	            if string.lower(b) == string.lower(a) then
	                TriggerClientEvent('DelVehicles:delete', -1)
	            end
	        end
	    end
	end
end)

function DeleteVehTaskCoroutine()
  TriggerClientEvent('DelVehicles:delete', -1)
end

for i = 1, #Config.DeleteVehiclesAt, 1 do
    TriggerEvent('cron:runAt', Config.DeleteVehiclesAt[i].h, Config.DeleteVehiclesAt[i].m, DeleteVehTaskCoroutine)
end

-- 2fast4u on da komputer malkiq dev
