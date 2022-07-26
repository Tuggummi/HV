local location = '^1{^2HV^1}^7 ~ '

RegisterCommand("repair", function(source)
    TriggerClientEvent("TPF_repairVehicle", source)
end)

RegisterCommand("clean", function(source)
    TriggerClientEvent("TPF_cleanVehicle", source)
end)

RegisterCommand("fix", function(source)
    if Config.everyoneAllowedFix then
        TriggerClientEvent("TPF_repairVehicle", source)
        TriggerClientEvent("TPF_cleanVehicle", source)
    else
        if not isAllowed(source) then
            TriggerClientEvent('chatMessage', source, "TPF", {148,0,211}, _T.notAllowed)
            return
        end
        TriggerClientEvent("TPF_repairVehicle", source)
        TriggerClientEvent("TPF_cleanVehicle", source)
    end
end)
    
local areAllowed = Config.allowed
function isAllowed(player)
    local allowed = false
    for i,id in ipairs(areAllowed) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end