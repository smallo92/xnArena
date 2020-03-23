Config = {}

Config.interiorCentre = vec(2798.267, -3787.388, 151.996)
Config.interiorID = 272385
Config.repairLocation = vec(2800.035, -3702.468, 139.0)
Config.markerColour = {r = 0, g = 125, b = 255, a = 100}

Config.vehPitEntry = vec(-389.0, -1880.0, 19.0)
Config.pedPitEntry = vec(-398.723, -1885.438, 21.539)
Config.vipPedtoPitLoc = vec(2819.599, -3935.208, 185.835)

Config.intPedLoc = vec(2750.407, -3696.649, 140.0)
Config.intPedHeading = 270.0

Config.vipPedLoc = vec(2816.607, -3935.174, 185.835)
Config.vipPedHeading = 180.0

Config.arenaPedLoc = vec(-282.142, -2031.302, 30.145)
Config.arenaPedHeading = 300.0

Config.pitLanePointA = vec3(2750.745, -3696.981, 138.5)
Config.pitLanePointB = vec3(2849.704, -3707.112, 142.0)

Config.markerColour = {r = 0, g = 125, b = 255, a = 100}
Config.markers = {
	{21, Config.vipPedLoc, vec(1.5, 1.0, 1.0), 50.0, true},
	{21, Config.arenaPedLoc, vec(1.5, 1.0, 1.0), 50.0, true},
	{21, Config.pedPitEntry, vec(1.5, 1.0, 1.0), 50.0, true},
	{21, Config.vipPedtoPitLoc, vec(1.5, 1.0, 1.0), 10.0, true},
	{1, Config.vehPitEntry, vec(5.0, 5.0, 3.0), 50.0, false},
}

Config.entitySets = {"Set_Pit_Fence_Oval", "Set_Team_Band_A", "Set_Team_Band_B", "Set_Team_Band_C", "Set_Team_Band_D", "set_lights_night", "set_nascar_01", "Set_Crowd_A", "Set_Crowd_B", "Set_Crowd_C", "Set_Crowd_D"}
Config.vehSpawns = {
	{ vec(2755.021, -3687.447, 140.0), 180.0 },
	{ vec(2765.021, -3687.447, 140.0), 180.0 },
	{ vec(2775.021, -3687.447, 140.0), 180.0 },
	{ vec(2785.021, -3687.447, 140.0), 180.0 },
	{ vec(2795.021, -3687.447, 140.0), 180.0 },
	{ vec(2805.021, -3687.447, 140.0), 180.0 },
	{ vec(2815.021, -3687.447, 140.0), 180.0 },
	{ vec(2825.021, -3687.447, 140.0), 180.0 },
	{ vec(2835.021, -3687.447, 140.0), 180.0 },
	{ vec(2845.021, -3687.447, 140.0), 180.0 }
}

Config.interactKey = 38 -- E