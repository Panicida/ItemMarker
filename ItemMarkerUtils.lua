ItemMarkerUtils = {}

function ItemMarkerUtils:IsItemLink(link)
	local _, _, type = ZO_LinkHandler_ParseLink(link)
	return type == "item"
end

function ItemMarkerUtils:HexToRGB(hex)
    local rhex, ghex, bhex = string.sub(hex, 1, 2), string.sub(hex, 3, 4), string.sub(hex, 5, 6)

    return tonumber(rhex, 16)/255, tonumber(ghex, 16)/255, tonumber(bhex, 16)/255
end