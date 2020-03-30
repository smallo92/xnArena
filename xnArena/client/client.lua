RequestIpl("xs_arena_banners_ipl") -- Exterior banners on Arena
RequestIpl("sp1_10_real_interior") -- Arena walkin interior

local ArenaObject
local RepairingVehicle = false
local handle = nil

function xnNotification(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(msg)
	DrawNotification(false, true)
end

function RepairVehicle(veh)
	PlaySoundFrontend(-1, Config.repairSound.soundLib, Config.repairSound.soundFile, 1)
	RepairingVehicle = true
	xnNotification(Config.text.repairStarted)
	SetTimeout(5000, function()
		SetVehicleFixed(veh)
		SetVehicleDirtLevel(veh, 0.0)
		xnNotification(Config.text.repairCompleted)
		RepairingVehicle = false
	end)
end

CreateThread(function()
	while true do 
		Wait(0)
		if RepairingVehicle then
			DisableControlAction(0, 75, true)
			DisableControlAction(0, 71, true)
			DisableControlAction(0, 72, true)
			DisableControlAction(0, 86, true)
		end
	end
end)

local waitTime = 500
CreateThread(function()
	while true do
		Wait(waitTime)
		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)
		for _, oldMarker in pairs(Config.teleports) do
			for _, multiMarkers in pairs(oldMarker.markerCoords) do
				if #(pedCoords - multiMarkers) < oldMarker.markerDrawDistance then
					Config.currentMarkers[multiMarkers] = {
						mType = oldMarker.markerType, 
						mCoords = multiMarkers, 
						mScale = oldMarker.markerScale, 
						mBob = oldMarker.markerBobUpAndDown
					}
				else
					Config.currentMarkers[multiMarkers] = nil
				end
			end
		end
		if next(Config.currentMarkers) then
			waitTime = 1
			for _, current in pairs(Config.currentMarkers) do
				DrawMarker(current.mType, current.mCoords, 0.0, 0.0, 0.0, 0, 0.0, 0.0, current.mScale, Config.markerColour.r, Config.markerColour.g, Config.markerColour.b, Config.markerColour.a, current.mBob, true)
			end
		else
			waitTime = 500
		end
	end
end)

CreateThread(function()
	while true do
		Wait(waitTime)
		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)
		for _, marker in pairs(Config.teleports) do
			for _, multiMarkers in pairs(marker.markerCoords) do
				if #(pedCoords - multiMarkers) < marker.markerScale.x / 2 then
					local veh = IsPedInAnyVehicle(ped)
					if not marker.allowVehicle and veh then
						form = setupScaleform("instructional_buttons", Config.text.noVehicle)
						DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
					else
						form = setupScaleform("instructional_buttons", marker.markerText, Config.interactKey)
						DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
						if IsControlJustReleased(0, Config.interactKey) then
							local spawnPoint = marker.destinationCoords[1]
							local tpEntity = ped
							if #marker.destinationCoords > 1 then
								spawnPoint = marker.destinationCoords[math.random(#marker.destinationCoords)]
							end
							if veh then
								tpEntity = GetVehiclePedIsIn(ped)
							end
							StartTeleport(spawnPoint, tpEntity, marker.imaps, marker.destination)
						end
					end
				end
			end
		end
	end
end)

CreateThread(function()
	local newWait = 500
	while true do
		Citizen.Wait(newWait)
		if DoesEntityExist(ArenaObject) then
			local ped = PlayerPedId()
			local pedCoords = GetEntityCoords(ped)
			if GetInteriorFromEntity(ped) == Config.interiorID and IsPedInAnyVehicle(ped) then
				newWait = 1
				local veh = GetVehiclePedIsIn(ped)
				if #(Config.repairLocation - pedCoords) < 75.0 then
					if IsEntityInArea(veh, Config.repairBox.pointA, Config.repairBox.pointB, 0, 0, 0) then
						if GetEntityHealth(veh) ~= GetEntityMaxHealth(veh) then
							if GetEntitySpeed(veh) == 0.0 then
								if not RepairingVehicle then
									form = setupScaleform("instructional_buttons", Config.text.repairVehicle, Config.interactKey)
									DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
									if IsControlJustReleased(0, Config.interactKey) then
										RepairVehicle(veh)
									end
								end
							else
								form = setupScaleform("instructional_buttons", Config.text.vehicleNotStopped)
								DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
							end
						else
							form = setupScaleform("instructional_buttons", Config.text.vehicleFullHealth)
							DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
						end
					end
				end
			else
				newWait = 500
			end
		else
			local ped = PlayerPedId()
			if not IsPedInAnyVehicle(ped, false) then
				if #(GetEntityCoords(ped) - Config.repairLocation) < 300.0 then
					local tpItem = Config.teleports.pedPitEntry
					StartTeleport(tpItem.destinationCoords[1], ped, tpItem.imaps, tpItem.destination)
				end
			end
		end
	end
end)

function StartTeleport(coords, entity, imaps, destination)
	PlaySoundFrontend(-1, Config.selectSound.soundLib, Config.selectSound.soundFile, true)
	BeginTextCommandBusyString("FMMC_PLYLOAD")
	EndTextCommandBusyString(4)
	DoScreenFadeOut(1000)
	Wait(1000)
		for imap, request in pairs(imaps) do
			if request then
				RequestIpl(imap)
			else
				RemoveIpl(imap)
			end
		end
		SetEntityCoords(entity, coords.x, coords.y, coords.z, false, false, false, false)
		SetEntityHeading(entity, coords.w)
		SetGameplayCamRelativeHeading(0.0)
		if destination == "arena" then
			TvLoad()
			CreateModelHide(Config.lightDummyLoc, 50.0, Config.lightDummyModel, 0)
			CreateModelHide(Config.structureLoc, 50.0, Config.structureModel, 0)
			local objectPlacement = GetOffsetFromInteriorInWorldCoords(Config.interiorID, Config.interiorOffset)
			ArenaObject = CreateObjectNoOffset(Config.structureModel, objectPlacement, false, false, false)
			SetEntityQuaternion(ArenaObject, Config.arenaObjectRotation)
		elseif destination == "vip" then
			TvLoad()
			RemoveModelHide(Config.lightDummyLoc, 50.0, Config.lightDummyModel, 0)
			CreateModelHide(Config.structureLoc, 50.0, Config.structureModel, 0)
			ArenaObject = CreateObjectNoOffset(Config.dummyModel, Config.dummyLoc, false, false, false)
		elseif destination == "outside" then
			CreateModelHide(Config.lightDummyLoc, 50.0, Config.lightDummyModel, 0)
			CreateModelHide(Config.structureLoc, 50.0, Config.structureModel, 0)
			DeleteEntity(ArenaObject)
			SetTvChannel(-1)
			ClearTvChannelPlaylist(0)
			SetTvAudioFrontend(0)
			handle = nil
			ArenaObject = nil
			for _, set in ipairs(Config.entitySets) do
				DeactivateInteriorEntitySet(Config.interiorID, set)
			end
			RefreshInterior(Config.interiorID)
		end
	Wait(1000)
	RemoveLoadingPrompt()
	DoScreenFadeIn(2000)
end

function TvLoad()
	handle = CreateNamedRenderTargetForModel("bigscreen_01", Config.tvModel)
	CreateThread(function()
		while true do
			SetTextRenderId(handle)
			SetUiLayer(4)
			SetScriptGfxDrawBehindPausemenu(1)
			DrawTvChannel(0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
			SetTextRenderId(GetDefaultScriptRendertargetRenderId())
			SetScriptGfxDrawBehindPausemenu(0)
			Wait(0)
		end
	end)
	SetTvChannelPlaylist(0, Config.tvChannel, 1)
	SetTvAudioFrontend(1)
	SetTvVolume(Config.tvVolume) -- Muted
	SetTvChannel(0)
	for _, set in ipairs(Config.entitySets) do
		EnableInteriorProp(Config.interiorID, set)
	end
	RefreshInterior(Config.interiorID)
end

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
        Wait(0)
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