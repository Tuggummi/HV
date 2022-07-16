Config = {
    -------------
    -- R  C  V --
    -------------
    
    --Repairs the car
    repairCommand = true,
    --Cleans the car
    cleanCommand = true,
    --Both repairs and cleans the car.
    fixCommand = true,

    -- If everyone is allowed to use "/repair" and "/clean" command.
    allowEveryoneToUse = true,

    -- If allowEveryOneToUse is false, then you need to specify who is allowed.
    allowed = {
        'steam:11000011a011b0c',
        'ip:12.345.67.890'
    },

    -- The fix command, available for everyone?
    allowFixForEveryone = false,

    -- Who is allowed to use "/fix", specify if allowFixForEveryone = false.
    allowedToFix = {
        'steam:11000011a011b0c',
        'ip:12.345.67.890'
    }

}