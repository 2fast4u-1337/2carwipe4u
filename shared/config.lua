Config, Locale = {}, {}

Config.locale = "en"

Config.Cmd = "deletevehicles"

Config.ESX = false -- Set this to true if you use ESX 

-- If you use ESX you don't need to add any identifier to Config.AdminList because it checks if you have permission by your player group (superadmin, admin, mod)

-- Accepted Identifiers : steam: | license: | xbl: | live: | discord: | fivem: | ip:
Config.AdminList = {
	'license:INSERTLICENSEHERE', -- Example, change this
	'license:INSERTLICENSEHERE' -- Example, change this
}

-- Time (in minutes) that it will take to delete vehicles since you execute the command
Config.DeleteVehicleTimer = 10

-- If true it'll delete vehicles inside safezones
Config.DeleteVehiclesIfInSafeZone = true

-- Delete vehicles automatically at this time every day (h = hour m = minutes)
Config.DeleteVehiclesAt = {
--	{['h'] = 20, ['m'] = 42},
--	{['h'] = 19, ['m'] = 20},
--	{['h'] = 19, ['m'] = 30},
}

-- Set safezones
-- For the blip color check: https://docs.fivem.net/docs/game-references/blips/#blip-colors
-- If you want to remove the blip simply set 'alpha' to 0
Config.SafeZones = {
--	{ ['x'] = -44.155646565, ['y'] = -1100.155646565, ['z'] = 26.267009735108, ['radius'] = 50.0, ['color'] = 2, ['alpha'] = 150},
--	{ ['x'] = -1688.43811035156, ['y'] = -1073.62536621094, ['z'] = 13.1521873474121, ['radius'] = 200.0, ['color'] = 2, ['alpha'] = 150},
--	{ ['x'] = -2195.1352539063, ['y'] = 4288.7290039063, ['z'] = 49.173923492432, ['radius'] = 150.0, ['color'] = 2, ['alpha'] = 150},
}
