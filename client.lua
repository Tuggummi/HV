local location = '^1{^2RCV^1}^7 ~ '

TriggerEvent("chat:addSuggestion", "/repair", _T.SuggestionRepair)
TriggerEvent("chat:addSuggestion", "/clean", _T.SuggestionClean)
TriggerEvent('chat:addSuggestion', "/v", _T.SuggestionSpawnVeh, {
    { name=_T.paramSuggestionName, help=_T.paramSuggestionDesc }
})
TriggerEvent("chat:addSuggestion", "/dv", _T.SuggestionDeleteVeh)


RegisterCommand("v", function(source, args)
    local vehicleName = args[1]

    if vehicleName == nil then
        TriggerEvent("chatMessage", "TPF", {148,0,211}, _T.noName)
        return
    end

    TriggerEvent("TPF_spawnVeh", source, vehicleName)
end)

RegisterCommand("dv", function(source)
    TriggerEvent("TPF_deleteVeh", source)
end)

RegisterNetEvent('TPF_repairVehicle')
AddEventHandler('TPF_repairVehicle', function()
    local ped = GetPlayerPed(-1)

    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
        local pos = GetEntityCoords(ped)

        if IsPedInAnyVehicle(ped, false) then
            local veh = GetVehiclePedIsIn(ped)
            SetVehicleEngineHealth(veh, 1000)
            SetVehicleEngineOn(veh, true, true)
            SetVehicleFixed(veh)
            TPFNotify(_T.beenRepaired)
        else
            local inFront = GetOffsetFromEntityInWorldCoords(ped, 0.0, distance, 0.0)
            local veh = GetVehicleCloseby(ped, pos, inFront)


            if ( DoesEntityExist(veh) ) then
                Wait(1500)
                SetVehicleEngineHealth(veh, 1000)
                SetVehicleEngineOn(veh, true, true)
                SetVehicleFixed(veh)

                TPFNotify(_T.beenRepaired)
            else
                TPFNotify(_T.closeToRepair)
            end
        end
    else
        TPFNotify(_T.aliveToRepair)
    end
end)

RegisterNetEvent("TPF_cleanVehicle")
AddEventHandler("TPF_cleanVehicle", function()
    local ped = GetPlayerPed(-1)

    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
        local pos = GetEntityCoords(ped)

        if IsPedInAnyVehicle(ped, false) then
            local veh = GetVehiclePedIsIn(ped)
            SetVehicleDirtLevel(veh, 0)
            SetVehicleFixed(veh)
            TPFNotify(_T.beenCleaned)
        else
            local inFront = GetOffsetFromEntityInWorldCoords(ped, 0.0, distance, 0.0)
            local veh = GetVehicleCloseby(ped, pos, inFront)


            if ( DoesEntityExist(veh) ) then
                Wait(1500)
                SetVehicleDirtLevel(veh, 0)
                SetVehicleFixed(veh)

                TPFNotify(_T.beenCleaned)
            else
                TPFNotify(_T.closeToClean)
            end
        end
    else
        TPFNotify(_T.aliveToClean)
    end
end)

-- SPAWN  /  DELETE --

RegisterNetEvent("TPF_spawnVeh")
AddEventHandler("TPF_spawnVeh", function(source, vehicleName)

    if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then
        TPFNotify(_T.dontExist, vehicleName)
        return
    end

    RequestModel(vehicleName)

    while not HasModelLoaded(vehicleName) do
        Wait(500)
    end

    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local vehicle = CreateVehicle(vehicleName, pos.x, pos.y, pos.z, GetEntityHeading(playerPed), true, false)

    SetPedIntoVehicle(playerPed, vehicle, -1)
    SetEntityAsNoLongerNeeded(vehicle)
    SetModelAsNoLongerNeeded(vehicle)
end)


local distance = 5.0
local retries = 5

RegisterNetEvent("TPF_deleteVeh")
AddEventHandler("TPF_deleteVeh", function()
    local ped = GetPlayerPed(-1)
    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
        local pos = GetEntityCoords(ped)

        if (IsPedSittingInAnyVehicle(ped)) then
            local vehicle = GetVehiclePedIsIn(ped, false)

            if ( GetPedInVehicleSeat(vehicle, -1) == ped) then
                DeleteTheVehicle(vehicle, retries)
            else
                TPFNotify(_T.frontSeat)
            end
        else
            local inFront = GetOffsetFromEntityInWorldCoords(ped, 0.0, distance, 0.0)
            local vehicle = GetVehicleCloseby(ped, pos, inFront)

            if ( DoesEntityExist(vehicle) ) then
                DeleteTheVehicle(vehicle, retries)
            else
                TPFNotify(_T.closeToDelete)
            end
        end
    end
end)


function GetVehicleCloseby(entFrom, coordFrom, coordTo)
    local rayHandle = StartShapeTestCapsule(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 5.0, 10, entFrom, 7)
    local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)

    if (IsEntityAVehicle(vehicle)) then 
        return vehicle
    end
end

function DeleteTheVehicle(veh, timeoutMax)
    local timeout = 0

    SetEntityAsMissionEntity(veh, true, true)
    DeleteVehicle(veh)

    if (DoesEntityExist(veh)) then
        TPFNotify(_T.failedToDelete)

        while ( DoesEntityExist(veh) and timeout < timeoutMax ) do
            DeleteVehicle(veh)

            if ( not DoesEntityExist(veh) ) then
                TPFNotify(_T.vehDeleted)
            end

            timeout = timeout + 1
            Citizen.Wait(500)

            if ( DoesEntityExist(veh) and (timeout == timeoutMax - 1)) then
                TPFNotify(_T.failedToDeleteAfterRetries .. " " .. timeoutMax.. "")
            end
        end
    else
        TPFNotify(_T.vehDeleted)
    end
end

function TPFNotify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(false, false)
end
