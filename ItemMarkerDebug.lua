ItemMarkerDebug = {}

local tconcat = table.concat

function ItemMarkerDebug:log(...)
    local args = {}
    for i = 1, select("#", ...) do
        args[i] = tostring(select(i, ...))
    end

    zo_callLater(function ()
        d(tconcat(args, " "))
    end, 50)
end
