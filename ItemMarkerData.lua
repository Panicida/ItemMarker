ItemMarkerData = {}

ItemMarkerData.KEEP_MARK = 0
ItemMarkerData.SELL_MARK = 1

function ItemMarkerData:GetMarkerAnchor()
    return self.savedVariables.markerAnchor
end

function ItemMarkerData:GetMarkerInfo(mark, itemInstanceId)
    local isItemMarked = self:IsItemMarked(itemInstanceId)

    if isItemMarked then
        return self.savedVariables.texture[mark], ItemMarkerUtils:HexToRGB(self.savedVariables.markerColor)
    end
end

function ItemMarkerData:ToogleItem(mark, itemInstanceId)
    self.savedVariables.markedItems[mark][itemInstanceId] = not self.savedVariables.markedItems[mark][itemInstanceId] or nil
end

function ItemMarkerData:IsItemMarked(itemInstanceId)
    local markInfo = {}
    markInfo.isKeep = self.savedVariables.markedItems[self.KEEP_MARK][itemInstanceId]
    markInfo.isSell = self.savedVariables.markedItems[self.SELL_MARK][itemInstanceId]
    return markInfo
end

function ItemMarkerData:Initialize()
    local defaults = {
        markedItems = {
            [self.KEEP_MARK] = {},
            [self.SELL_MARK] = {}
        },
        texture = {
            [self.KEEP_MARK] = ItemMarkerConstants.textures.lock,
            [self.SELL_MARK] = ItemMarkerConstants.textures.sell
        },
        markerAnchor = {
            [self.KEEP_MARK] = TOPLEFT,
            [self.SELL_MARK] = BOTTOMLEFT
        },
        markerColor = "ffff00",
        recipies = {}
    }

    self.savedVariables = ZO_SavedVars:NewAccountWide(ItemMarkerConfig.savedVariablesFile, 1, nil, defaults)
end
