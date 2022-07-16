-- DO NOT EDIT ANYTHING HERE; YOU ARE PROHIBITED AND YOU CAN RUIN THE RESOURCE! --

-- Setting the variables.
local location = '^1{^2RCV^1}^7 ~ '

local repairCommand = Config.repairCommand
local cleanCommand = Config.cleanCommand
local fixCommand = Config.fixCommand

local everyoneAllowed = Config.allowEveryoneToUse
local allowedToUse = Config.allowed

-- Creating the commands

if repairCommand then
    RegisterCommand("repair", function(source)
        if everyoneAllowed then
            TriggerClientEvent("TPF_repairVehicle", source)
        else
            if not isAllowed(source) then
                TriggerClientEvent("chatMessage", source, "TPF", {148,0,211} , _T.notAllowed)
                return
            end
            TriggerClientEvent("TPF_repairVehicle", source)
        end
    end)
end

if cleanCommand then
    RegisterCommand("clean", function(source)
        if everyoneAllowed then
            TriggerClientEvent("TPF_cleanVehicle", source)
        else
            if not isAllowed(source) then
                TriggerClientEvent("chatMessage", source, "TPF", {148,0,211} , _T.notAllowed)
                return
            end
            TriggerClientEvent("TPF_cleanVehicle", source)
        end
    end)
end

local everyoneAllowedToFix = Config.allowFixForEveryone
local allowedToFix = Config.allowedToFix

if fixCommand then
    RegisterCommand("fix", function(source)
        if everyoneAllowedToFix then
            TriggerClientEvent("TPF_repairVehicle", source)
            Wait(500)
            TriggerClientEvent("TPF_cleanVehicle", source)
        else
            if not isAllowedFix(source) then
                TriggerClientEvent("chatMessage", source, "TPF", {148,0,211} , _T.notAllowed)
                return
            end
            TriggerClientEvent("TPF_repairVehicle", source)
            Wait(500)
            TriggerClientEvent("TPF_cleanVehicle", source)
        end
    end)
end


function isAllowed(player)
    local allowed = false
    for i,id in ipairs(allowedToUse) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end

function isAllowedFix(player)
    local allowed = false
    for i,id in ipairs(allowedToFix) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end