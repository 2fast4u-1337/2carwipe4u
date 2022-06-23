local QBCore = exports['qb-core']:GetCoreObject()

function _L(str)
    if not Locale then return "Locale error" end
    if not Locale[Config.locale] then return "Invalid locale" end
    if not Locale[Config.locale][str] then return "Invalid string" end
    return Locale[Config.locale][str]
end

Citizen.CreateThread(function()
	for i = 1, #Config.SafeZones, 1 do
		local blip = AddBlipForRadius(Config.SafeZones[i].x, Config.SafeZones[i].y, Config.SafeZones[i].z, Config.SafeZones[i].radius)
		SetBlipColour(blip, Config.SafeZones[i].color)
		SetBlipAlpha(blip, Config.SafeZones[i].alpha)
	end
end)

RegisterNetEvent("DelVehicles:delete")
AddEventHandler("DelVehicles:delete", function()
	local minuteCalculation = 1000
	local minutesPassed = 0
	local minutesLeft = Config.DeleteVehicleTimer
	QBCore.Functions.Notify('All vehicles will be deleted in 1 minute')
	Wait(50000)
	QBCore.Functions.Notify(_L("first_message"):format(math.floor(minutesLeft)))

	while minutesPassed < Config.DeleteVehicleTimer do
		Citizen.Wait(1*minuteCalculation)
		minutesPassed = minutesPassed + 1
		minutesLeft = minutesLeft - 1
		if minutesLeft == 0 then
			QBCore.Functions.Notify(_L("deleted_vehicles"))
		elseif minutesLeft == 1 then
			QBCore.Functions.Notify(_L("deleted_in_min"):format(math.floor(minutesLeft)))
		else
			QBCore.Functions.Notify(_L("deleted_in_mins"):format(math.floor(minutesLeft)))
		end
	end
	for vehicle in EnumerateVehicles() do
		local canDelete = true
		local carCoords = GetEntityCoords(vehicle)

		if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then
			if not Config.DeleteVehiclesIfInSafeZone then
				for i = 1, #Config.SafeZones, 1 do
					dist = Vdist(Config.SafeZones[i].x, Config.SafeZones[i].y, Config.SafeZones[i].z, carCoords.x, carCoords.y, carCoords.z)
					if dist < Config.SafeZones[i].radius then
						canDelete = false
					end
				end
			end
			if canDelete then
				SetVehicleHasBeenOwnedByPlayer(vehicle, false) 
				SetEntityAsMissionEntity(vehicle, false, false) 
				DeleteVehicle(vehicle)
				if (DoesEntityExist(vehicle)) then 
					DeleteVehicle(vehicle) 
				end
			end
		end
	end
end)

local entityEnumerator = {
	__gc = function(enum)
	if enum.destructor and enum.handle then
		enum.destructor(enum.handle)
	end
	enum.destructor = nil
	enum.handle = nil
end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end
