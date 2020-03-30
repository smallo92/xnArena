Config = {}

Config.entitySets = {"Set_Pit_Fence_Oval", "Set_Team_Band_A", "Set_Team_Band_B", "Set_Team_Band_C", "Set_Team_Band_D", "set_lights_night", "set_nascar_01", "Set_Crowd_A", "Set_Crowd_B", "Set_Crowd_C", "Set_Crowd_D"}

Config.repairLocation = vec(2800.035, -3702.468, 139.0)
Config.repairBox = {
	pointA = vec(2750.745, -3696.981, 138.5),
	pointB = vec(2849.704, -3707.112, 142.0)
}

Config.markerColour = {r = 0, g = 125, b = 255, a = 100} -- Blue (0, 125, 255, 100)
Config.interactKey = 38 -- E

Config.tvModel = `xs_prop_arena_bigscreen_01`
Config.tvChannel = "PL_STD_CNT" -- All available playlists in `tvplaylists.xml` look it up in the Codewalker RPF Browser
Config.tvVolume = -100.0 -- Muted (-100.0)

Config.repairSound = {soundLib = "Timer_5s", soundFile = "GTAO_FM_Events_Soundset"}
Config.selectSound = {soundLib = "SELECT", soundFile = "HUD_FRONTEND_DEFAULT_SOUNDSET"}

Config.text = {
	enterPitLanes = "Enter Pit Lanes",
	exitPitLanes = "Exit Pit Lanes",
	enterVipBox = "Enter VIP Box",
	exitVipBox = "Exit VIP Box",
	repairStarted = "Repair has started, please wait...",
	repairCompleted = "Repair Complete",
	repairVehicle = "Repair vehicle",
	noVehicle = "You cannot enter here in a vehicle",
	vehicleNotStopped = "You must be at a complete stop to repair your vehicle",
	vehicleFullHealth = "Your vehicle already is already at full health"
}

Config.teleports = {
	vehiclePitEntry = {
		markerType = 1,
		markerCoords = {
			vec(-389.0, -1880.0, 19.0)
		},
		markerScale = vec(5.0, 5.0, 3.0),
		markerDrawDistance = 50.0,
		markerBobUpAndDown = false,
		allowVehicle = true,
		markerText = Config.text.enterPitLanes,
		destinationCoords = {
			vec(2755.021, -3687.447, 140.0, 180.0),
			vec(2765.021, -3687.447, 140.0, 180.0),
			vec(2775.021, -3687.447, 140.0, 180.0),
			vec(2785.021, -3687.447, 140.0, 180.0),
			vec(2795.021, -3687.447, 140.0, 180.0),
			vec(2805.021, -3687.447, 140.0, 180.0),
			vec(2815.021, -3687.447, 140.0, 180.0),
			vec(2825.021, -3687.447, 140.0, 180.0),
			vec(2835.021, -3687.447, 140.0, 180.0),
			vec(2845.021, -3687.447, 140.0, 180.0)
		},
		imaps = {
			["xs_arena_interior"] = true
		},
		destination = "arena"
	},
	vehiclePitExit = {
		markerType = 1,
		markerCoords = {
			vec(2755.021, -3687.447, 139.0),
			vec(2765.021, -3687.447, 139.0),
			vec(2775.021, -3687.447, 139.0),
			vec(2785.021, -3687.447, 139.0),
			vec(2795.021, -3687.447, 139.0),
			vec(2805.021, -3687.447, 139.0),
			vec(2815.021, -3687.447, 139.0),
			vec(2825.021, -3687.447, 139.0),
			vec(2835.021, -3687.447, 139.0),
			vec(2845.021, -3687.447, 139.0)
		},
		markerScale = vec(5.0, 5.0, 3.0),
		markerDrawDistance = 25.0,
		markerBobUpAndDown = false,
		allowVehicle = true,
		markerText = Config.text.exitPitLanes,
		destinationCoords = {
			vec(-389.0, -1880.0, 19.0, 330.0)
		},
		imaps = {
			["xs_arena_interior"] = false
		},
		destination = "outside"
	},
	pedPitEntry = {
		markerType = 21,
		markerCoords = {
			vec(-398.723, -1885.438, 21.539)
		},
		markerScale = vec(1.5, 1.0, 1.0),
		markerDrawDistance = 50.0,
		markerBobUpAndDown = true,
		allowVehicle = false,
		markerText = Config.text.enterPitLanes,
		destinationCoords = {
			vec(2750.407, -3696.649, 140.0, 188.0)
		},
		imaps = {
			["xs_arena_interior"] = true
		},
		destination = "arena"
	},
	pedVipEntry = {
		markerType = 21,
		markerCoords = {
			vec(-282.142, -2031.302, 30.145)
		},
		markerScale = vec(1.5, 1.0, 1.0),
		markerDrawDistance = 50.0,
		markerBobUpAndDown = true,
		allowVehicle = false,
		markerText = Config.text.enterVipBox,
		destinationCoords = {
			vec(2816.607, -3935.174, 185.835, 180.0)
		},
		imaps = {
			["xs_arena_interior"] = true,
			["xs_arena_interior_vip"] = true
		},
		destination = "vip"
	},
	pedVipExit = {
		markerType = 21,
		markerCoords = {
			vec(2816.607, -3935.174, 185.835)
		},
		markerScale = vec(1.5, 1.0, 1.0),
		markerDrawDistance = 10.0,
		markerBobUpAndDown = true,
		allowVehicle = false,
		markerText = Config.text.exitVipBox,
		destinationCoords = {
			vec(-282.142, -2031.302, 30.145, 180.0)
		},
		imaps = {
			["xs_arena_interior"] = false,
			["xs_arena_interior_vip"] = false
		},
		destination = "outside"
	},
	pedVipToArenaEntry = {
		markerType = 21,
		markerCoords = {
			vec(2819.599, -3935.208, 185.835)
		},
		markerScale = vec(1.5, 1.0, 1.0),
		markerDrawDistance = 10.0,
		markerBobUpAndDown = true,
		allowVehicle = false,
		markerText = Config.text.enterPitLanes,
		destinationCoords = {
			vec(2750.407, -3696.649, 140.0, 270.0)
		},
		imaps = {
			["xs_arena_interior"] = true,
			["xs_arena_interior_vip"] = false
		},
		destination = "arena"
	},
}

---------------------------------------------------------------------------
--			It's not recommended to edit anything below this point	 	 --
---------------------------------------------------------------------------

Config.interiorID = 272385

Config.currentMarkers = {} -- This is intended to be empty, don't change it

Config.lightDummyLoc = vec(2800.957, -3930.407, 180.493)
Config.lightDummyModel = `xs_x18intvip_vip_light_dummy`
Config.structureLoc = vec(2799.999, -3915.813, 179.9695)
Config.structureModel = `xs_propintarena_structure_s_05b`
Config.interiorOffset = vec(-0.00115500, -115.81260000, 79.96947000)
Config.arenaObjectRotation = vec(0.0, 0.0, 1.0, 0.0)
Config.dummyLoc = vec(-100.0, -100.0 -100.0)
Config.dummyModel = `prop_alien_egg_01`