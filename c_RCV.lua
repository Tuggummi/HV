-- DO NOT EDIT ANYTHING HERE; YOU ARE PROHIBITED AND YOU CAN RUIN THE RESOURCE! --

local location = '^1{^2RCV^1}^7 ~ '


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

-- Adding the suggestions for the commands
TriggerEvent("chat:addSuggestion", "/repair", _T.SuggestionRepair)
TriggerEvent("chat:addSuggestion", "/clean", _T.SuggestionClean)

function GetVehicleCloseby(entFrom, coordFrom, coordTo)
    local rayHandle = StartShapeTestCapsule(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 5.0, 10, entFrom, 7)
    local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)

    if (IsEntityAVehicle(vehicle)) then 
        return vehicle
    end
end

function TPFNotify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(false, false)
end
