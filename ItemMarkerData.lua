ItemMarkerData = {}

ItemMarkerData.KEEP_MARK = 1
ItemMarkerData.SELL_MARK = 2

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
    itemInstanceId = tostring(itemInstanceId)

    ItemMarkerDebug:log("Toogle", mark, "of", itemInstanceId)
    ItemMarkerDebug:log("Before", self.savedVariables.markedItems[mark][itemInstanceId])
    self.savedVariables.markedItems[mark][itemInstanceId] = not self.savedVariables.markedItems[mark][itemInstanceId] or nil
    ItemMarkerDebug:log("After", self.savedVariables.markedItems[mark][itemInstanceId])
end

function ItemMarkerData:IsItemMarked(itemInstanceId)
    itemInstanceId = tostring(itemInstanceId)

    local markInfo = {}
    markInfo.isKeep = self.savedVariables.markedItems[self.KEEP_MARK][itemInstanceId]
    markInfo.isSell = self.savedVariables.markedItems[self.SELL_MARK][itemInstanceId]
    return markInfo
end

function ItemMarkerData:GetTexture(mark)
    return self.savedVariables.texture[mark]
end

function ItemMarkerData:SetTexture(mark, texture)
    self.savedVariables.texture[mark] = texture
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
