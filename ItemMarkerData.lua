ItemMarkerData = {}

ItemMarkerData.savedVariablesFile = "ItemMarkerSavedVariables"

function ItemMarkerData:GetMarkerAnchor()
    return self.savedVariables.markerAnchor
end

function ItemMarkerData:GetMarkerInfo(itemInstanceId)
    local isItemMarked = self:IsItemMarked(itemInstanceId)

    if isItemMarked then
        return self.savedVariables.markersInfo[self.savedVariables.marker], ItemMarkerUtils:HexToRGB(self.savedVariables.markerColor) 
    end
end

function ItemMarkerData:ToogleItem(itemInstanceId)
    self.savedVariables.markedItems[itemInstanceId] = not self.savedVariables.markedItems[itemInstanceId] or nil
end

function ItemMarkerData:IsItemMarked(itemInstanceId)
    return self.savedVariables.markedItems[itemInstanceId]
end

function ItemMarkerData:Initialize()
    local defaults = {
        markedItems = {},
        marker = "star",
        markerAnchor = 3,
        markersInfo = {
            star = [[/esoui/art/campaign/overview_indexicon_bonus_disabled.dds]]
        },
        markerColor = "ffff00"
    }

    self.savedVariables = ZO_SavedVars:NewAccountWide(self.savedVariablesFile, 1, nil, defaults)
end
