RequestIpl("xs_arena_banners_ipl")
local ArenaObject
local RepairingVehicle = false

function ArenaLoad()
	RequestIpl("xs_arena_interior")
	CreateModelHide(2800.957, -3930.407, 180.493, 50.0, "xs_x18intvip_vip_light_dummy", 0)
	CreateModelHide(2799.999, -3915.813, 179.9695, 50.0, "xs_propintarena_structure_s_05b", 0)
	for _, set in ipairs(Config.entitySets) do
		EnableInteriorProp(Config.interiorID, set)
	end
	RefreshInterior(Config.interiorID)
	local objectPlacement = GetOffsetFromInteriorInWorldCoords(Config.interiorID, -0.00115500, -115.81260000, 79.96947000)
	ArenaObject = CreateObjectNoOffset("xs_propintarena_structure_s_05b", objectPlacement, 0, 1, 0)
	SetEntityQuaternion(ArenaObject, 0.0, 0.0, 1.0, 0.0)
    SetModelAsNoLongerNeeded("xs_propintarena_structure_s_05b")
	TVLoad()
end

function VIPLoad()
	RequestIpl("xs_arena_interior_vip")
	RequestIpl("xs_arena_interior")
	RemoveModelHide(2800.957, -3930.407, 180.493, 50.0, "xs_x18intvip_vip_light_dummy", 0)
	CreateModelHide(2799.999, -3915.813, 179.9695, 50.0, "xs_propintarena_structure_s_05b", 0)
	ArenaObject = CreateObjectNoOffset("prop_alien_egg_01", -100.0, -100.0 -100.0, 0, 1, 0)
	for _, set in ipairs(Config.entitySets) do
		EnableInteriorProp(Config.interiorID, set)
	end
	RefreshInterior(Config.interiorID)
	TVLoad()
    SetModelAsNoLongerNeeded("prop_alien_egg_01")
end

function TVLoad()
	local tvModel = "xs_prop_arena_bigscreen_01"
	local tvPos = vec3(2798.267, -3787.388, 151.996)
	local tvEntity = GetClosestObjectOfType(tvPos, 0.05, tvModel, 0, 0, 0)
	local handle = CreateNamedRenderTargetForModel("bigscreen_01", tvModel)
	Citizen.CreateThread(function()
		while true do
			SetTextRenderId(handle)
			SetUiLayer(4)
			SetScriptGfxDrawBehindPausemenu(1)
			DrawTvChannel(0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
			SetTextRenderId(GetDefaultScriptRendertargetRenderId())
			SetScriptGfxDrawBehindPausemenu(0)
			Citizen.Wait(0)
		end
	end)
	LoadTvChannelSequence(0, "PL_STD_CNT", 1)
	SetTvAudioFrontend(1)
	SetTvVolume(-100.0)
	SetTvChannel(0)
end

function OnUnloadInterior()
	DeleteEntity(ArenaObject)
	RemoveIpl("xs_arena_interior_vip")
	RemoveIpl("xs_arena_interior")
	for _, set in ipairs(Config.entitySets) do
		DisableInteriorProp(Config.interiorID, set)
	end
	RefreshInterior(Config.interiorID)
end

function EnterVIPBox()
	PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
	BeginTextCommandBusyString("FMMC_PLYLOAD")
	EndTextCommandBusyString(4)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
		DeleteEntity(ArenaObject)
		SetEntityCoords(PlayerPedId(), Config.vipPedLoc, false, false, false, false)
		SetEntityHeading(PlayerPedId(), Config.vipPedHeading)
		SetGameplayCamRelativeHeading(0.0)
		VIPLoad()
	Citizen.Wait(1000)
	DoScreenFadeIn(2000)
	Citizen.Wait(1000)
	RemoveLoadingPrompt()
end

function EnterPitVeh()
	PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
	local ped = PlayerPedId()
	local pedVeh = GetVehiclePedIsIn(PlayerPedId())
	local vehSpawn = Config.vehSpawns[math.random(#Config.vehSpawns)]
	BeginTextCommandBusyString("FMMC_PLYLOAD")
	EndTextCommandBusyString(4)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
		SetEntityCoords(pedVeh, vehSpawn[1], false, false, false, false)
		SetEntityHeading(pedVeh, vehSpawn[2])
		SetGameplayCamRelativeHeading(0.0)
		ArenaLoad()
	Citizen.Wait(1000)
	DoScreenFadeIn(2000)
	Citizen.Wait(1000)
	RemoveLoadingPrompt()
end

function EnterPitPed()
	LoadInterior()
	PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
	BeginTextCommandBusyString("FMMC_PLYLOAD")
	EndTextCommandBusyString(4)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
		SetEntityCoords(PlayerPedId(), Config.intPedLoc, false, false, false, false)
		SetEntityHeading(PlayerPedId(), Config.intPedHeading)
		SetGameplayCamRelativeHeading(0.0)
		ArenaLoad()
	Citizen.Wait(1000)
	DoScreenFadeIn(2000)
	Citizen.Wait(1000)
	RemoveLoadingPrompt()
end

function ExitVIPBox()
	PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
	BeginTextCommandBusyString("FMMC_PLYLOAD")
	EndTextCommandBusyString(4)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
		SetEntityCoords(PlayerPedId(), Config.arenaPedLoc, false, false, false, false)
		SetEntityHeading(PlayerPedId(), Config.arenaPedHeading)
		SetGameplayCamRelativeHeading(0.0)
		OnUnloadInterior()
	Citizen.Wait(1000)
	DoScreenFadeIn(2000)
	Citizen.Wait(1000)
	RemoveLoadingPrompt()
end

function EnterPitfromVIPPed()
	PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
	BeginTextCommandBusyString("FMMC_PLYLOAD")
	EndTextCommandBusyString(4)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
		OnUnloadInterior()
		SetEntityCoords(PlayerPedId(), Config.intPedLoc, false, false, false, false)
		SetEntityHeading(PlayerPedId(), Config.intPedHeading)
		SetGameplayCamRelativeHeading(0.0)
		ArenaLoad()
	Citizen.Wait(1000)
	DoScreenFadeIn(2000)
	Citizen.Wait(1000)
	RemoveLoadingPrompt()
end

function ExitArena()
	PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
	BeginTextCommandBusyString("FMMC_PLYLOAD")
	EndTextCommandBusyString(4)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
		if IsPedInAnyVehicle(PlayerPedId(), true) then
			SetEntityCoords(GetVehiclePedIsIn(PlayerPedId()), Config.vehPitEntry, false, false, false, false)
			SetEntityHeading(GetVehiclePedIsIn(PlayerPedId()), 26.0)
			SetGameplayCamRelativeHeading(0.0)
			OnUnloadInterior()
		else
			SetEntityCoords(PlayerPedId(), Config.pedPitEntry, false, false, false, false)
			SetEntityHeading(PlayerPedId(), 26.0)
			SetGameplayCamRelativeHeading(0.0)
			OnUnloadInterior()
		end
	Citizen.Wait(1000)
	DoScreenFadeIn(2000)
	Citizen.Wait(1000)
	RemoveLoadingPrompt()
end

function xnNotification(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(msg)
	DrawNotification(false, true)
end

function RepairVehicle()
	PlaySoundFrontend(-1, "Timer_5s", "GTAO_FM_Events_Soundset", 1)
	RepairingVehicle = true
	xnNotification("Repair has started, please wait...")
	SetTimeout(5000, function()
		SetVehicleFixed(GetVehiclePedIsIn(PlayerPedId()))
		SetVehicleDirtLevel(GetVehiclePedIsIn(PlayerPedId()), 0.0)
		xnNotification("Repair Complete.")
		RepairingVehicle = false
	end)
end

Citizen.CreateThread(function()
	while RepairingVehicle do 
		Citizen.Wait(0)
		DisableControlAction(0, 75, true)
		DisableControlAction(0, 71, true)
		DisableControlAction(0, 72, true)
		DisableControlAction(0, 86, true)
	end
end)

Citizen.CreateThread(function()
	local waitTime = 500
	while true do
		Citizen.Wait(waitTime)
		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)
		for _, marker in pairs(Config.markers) do
			if #(pedCoords - marker[2]) < marker[4] then
				waitTime = 1
				DrawMarker(marker[1], marker[2], 0.0, 0.0, 0.0, 0, 0.0, 0.0, marker[3], Config.markerColour.r, Config.markerColour.g, Config.markerColour.b, Config.markerColour.a, marker[5], true)
			else
				waitTime = 500
			end
		end
	end
end)

Citizen.CreateThread(function()
	local waitTime = 500
	while true do
		Citizen.Wait(waitTime)
		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)
		if #(pedCoords - Config.vehPitEntry) < 3.0 then
			waitTime = 1
			if IsPedInAnyVehicle(ped, true) then
				form = setupScaleform("instructional_buttons", "Enter Pit Lanes", Config.interactKey)
				DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
				if IsControlJustReleased(2, Config.interactKey) then
					EnterPitVeh()
				end
			else
				form = setupScaleform("instructional_buttons", "You must be in a vehicle to enter the pit lanes from here. Try the stairs next to you.")
				DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
			end
		else
			waitTime = 500
		end
	end
end)

Citizen.CreateThread(function()
	local waitTime = 500
	while true do
		Citizen.Wait(waitTime)
		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)
		if #(pedCoords - Config.vipPedtoPitLoc) < 1.0 then
			waitTime = 1
			if not IsPedInAnyVehicle(ped, true) then
				form = setupScaleform("instructional_buttons", "Enter Pit Lanes", Config.interactKey)
				DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
				if IsControlJustReleased(2, Config.interactKey) then
					EnterPitfromVIPPed()
				end
			else
				form = setupScaleform("instructional_buttons", "How the hell did you get a vehicle here?.")
				DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
			end
		else
			waitTime = 500
		end
	end
end)

Citizen.CreateThread(function()
	local waitTime = 500
	while true do
		Citizen.Wait(waitTime)
		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)
		if #(pedCoords - Config.pedPitEntry) < 1.0 then
			waitTime = 1
			if not IsPedInAnyVehicle(ped, true) then
				form = setupScaleform("instructional_buttons", "Enter Pit Lanes", Config.interactKey)
				DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
				if IsControlJustReleased(2, Config.interactKey) then
					EnterPitPed()
				end
			else
				form = setupScaleform("instructional_buttons", "You must be on foot to enter the pit lanes from here. Try the garage down the stairs.")
				DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
			end
		else
			waitTime = 500
		end
	end
end)

Citizen.CreateThread(function()
	local waitTime = 500
	while true do
		Citizen.Wait(waitTime)
		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)
		if #(pedCoords - Config.arenaPedLoc) < 1.0 then
			waitTime = 1
			if not IsPedInAnyVehicle(ped, true) then
				form = setupScaleform("instructional_buttons", "Enter the VIP box", Config.interactKey)
				DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
				if IsControlJustReleased(2, Config.interactKey) then
					EnterVIPBox()
				end
			else
				form = setupScaleform("instructional_buttons", "How the hell did you get a vehicle in here?")
				DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
			end
		else
			waitTime = 500
		end
	end
end)

Citizen.CreateThread(function()
	local waitTime = 500
	while true do
		Citizen.Wait(waitTime)
		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)
		if #(pedCoords - Config.vipPedLoc) < 1.0 then
			waitTime = 1
			if not IsPedInAnyVehicle(ped, true) then
				form = setupScaleform("instructional_buttons", "Exit the VIP box", Config.interactKey)
				DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
				if IsControlJustReleased(2, Config.interactKey) then
					ExitVIPBox()
				end
			else
				form = setupScaleform("instructional_buttons", "How the hell did you get a vehicle in here?")
				DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
			end
		else
			waitTime = 500
		end
	end
end)

Citizen.CreateThread(function()
	local waitTime = 500
	while true do
		Citizen.Wait(waitTime)
		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)
		if GetInteriorFromEntity(ped) == Config.interiorID then
			waitTime = 1
			if IsPedInAnyVehicle(ped, true) then
				local pedVeh = GetVehiclePedIsIn(ped, false)
				if #(pedCoords - Config.repairLocation) < 75.0 then
					if IsEntityInArea(pedVeh, 2750.745, -3696.981, 138.5, 2849.704, -3707.112, 142.0, 0, 0, 0) then
						if IsPedInAnyVehicle(ped, true) then
							if GetEntityHealth(pedVeh) ~= GetEntityMaxHealth(pedVeh) then
								if GetEntitySpeed(pedVeh) == 0.0 then
									if not RepairingVehicle then
										form = setupScaleform("instructional_buttons", "Repair Vehicle", Config.interactKey)
										DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
										if IsControlJustReleased(2, Config.interactKey) then
											RepairVehicle()
										end
									end
								else
									form = setupScaleform("instructional_buttons", "You must be at a complete stop to repair your vehicle.")
									DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
								end
							else
								form = setupScaleform("instructional_buttons", "Your vehicle already is already at full health.")
								DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
							end
						end
					end
				end
			end
			for k,v in pairs(Config.vehSpawns) do
				if #(pedCoords - v[1]) < 50.0 then
					local coords = v[1]
					DrawMarker(1, coords.x, coords.y, coords.z - 1.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 5.0, 5.0, 3.0, Config.markerColour.r, Config.markerColour.g, Config.markerColour.b, Config.markerColour.a, false, false, 2, false, false, false, false)
					if #(pedCoords - coords) < 3.0 then
						form = setupScaleform("instructional_buttons", "Exit Arena", Config.interactKey)
						DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
						if IsControlJustReleased(2, Config.interactKey) then
							ExitArena()
						end
					end
				end
			end
		else
			waitTime = 500
		end
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(0)
		if not IsPedInAnyVehicle(PlayerPedId(), false) then
			local ped = PlayerPedId()
			if #(GetEntityCoords(ped) - Config.interiorCentre) < 300.0 then
				if not DoesEntityExist(ArenaObject) then
					EnterPitPed()
				end
			end
		end
	end
end)

function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function Button(ControlButton)
    PushScaleformMovieMethodParameterButtonName(ControlButton)
end

function setupScaleform(scaleform, itemString, button)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
	if button ~= nil then
		Button(GetControlInstructionalButton(2, button, true))
	end
    ButtonMessage(itemString)
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()
    return scaleform
end

function ShowNotification(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(msg)
	DrawNotification(false, true)
end

function CreateNamedRenderTargetForModel(name, model)
	local handle = 0
	if not IsNamedRendertargetRegistered(name) then
		RegisterNamedRendertarget(name, 0)
	end
	if not IsNamedRendertargetLinked(model) then
		LinkNamedRendertarget(model)
	end
	if IsNamedRendertargetRegistered(name) then
		handle = GetNamedRendertargetRenderId(name)
	end
	return handle
end