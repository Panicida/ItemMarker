ItemMarkerControl = {}

ItemMarkerControl.keepMarkerName = "ItemMarker_Keep"
ItemMarkerControl.sellMarkerName = "ItemMarker_Sell"
ItemMarkerControl.libFilters = LibFilters3
ItemMarkerControl.texturePaths = {
    [ItemMarkerConstants.textures.star] = [[/esoui/art/campaign/overview_indexicon_bonus_disabled.dds]],
    [ItemMarkerConstants.textures.sell] = [[esoui\art\inventory\inventory_sell_forbidden_icon.dds]],
    [ItemMarkerConstants.textures.lock] = [[esoui\art\inventory\inventory_sell_forbidden_icon.dds]]
}




function ItemMarkerControl:RefreshControl(itemInstanceId, control)
    local function getMarkerAnchorOffsets(markerAnchor)
        local offsetValue = 10
        local offsets = {
            [TOPLEFT] = {
                x = -offsetValue,
                y = -offsetValue,
            },
            [TOP] = {
                x = 0,
                y = -offsetValue,
            },
            [TOPRIGHT] = {
                x = offsetValue,
                y = -offsetValue,
            },
            [RIGHT] = {
                x = offsetValue,
                y = 0,
            },
            [BOTTOMRIGHT] = {
                x = offsetValue,
                y = offsetValue,
            },
            [BOTTOM] = {
                x = 0,
                y = offsetValue,
            },
            [BOTTOMLEFT] = {
                x = -offsetValue,
                y = offsetValue,
            },
            [LEFT] = {
                x = -offsetValue,
                y = 0,
            },
            [CENTER] = {
                x = 0,
                y = 0,
            },
        }

        return offsets[markerAnchor].x, offsets[markerAnchor].y
    end

    local function refreshControl(mark, isMarked, markerName, markerAnchor)
        local markerControl = control:GetNamedChild(markerName)

        if not markerControl then
            markerControl = WINDOW_MANAGER:CreateControl(control:GetName() .. markerName, control, CT_TEXTURE)
            markerControl:SetDimensions(32, 32)
            markerControl:SetDrawTier(DT_HIGH)
        end

        local texture, r, g, b = ItemMarkerData:GetMarkerInfo(mark, itemInstanceId)
        local anchorTarget = control:GetNamedChild("Button")
        local offsetX, offsetY = getMarkerAnchorOffsets(markerAnchor)

        if anchorTarget then
            --list control
            anchorTarget = anchorTarget:GetNamedChild("Icon")
        else
            --equipment control
            anchorTarget = control:GetNamedChild("Icon")
        end

        --there's no anchor target. How'd we get here?
        if not anchorTarget then
            return
        end

        markerControl:SetHidden(not isMarked)
        markerControl:SetTexture(self.texturePaths[texture])
        markerControl:SetColor(r, g, b)
        markerControl:ClearAnchors()
        markerControl:SetAnchor(markerAnchor, anchorTarget, markerAnchor, offsetX, offsetY)
    end

    local itemMarkInfo = ItemMarkerData:IsItemMarked(itemInstanceId)
    local itemAnchorInfo = ItemMarkerData:GetMarkerAnchor()
    refreshControl(ItemMarkerData.KEEP_MARK, itemMarkInfo.isKeep, self.keepMarkerName, itemAnchorInfo[ItemMarkerData.KEEP_MARK])
    refreshControl(ItemMarkerData.SELL_MARK, itemMarkInfo.isSell, self.sellMarkerName, itemAnchorInfo[ItemMarkerData.SELL_MARK])
end

function ItemMarkerControl:RefreshAll()
    for _, list in pairs(ItemMarkerConfig.lists) do
        LibFilters3:RequestUpdate(list.filter)
    end
end

function ItemMarkerControl:GetInfoFromInventorySlotControl(inventorySlotControl)
    local bagId, slotIndex
    local link = nil
    local slotType = ZO_InventorySlot_GetType(inventorySlotControl)

    if ItemMarkerConfig.lists[slotType] then
        bagId, slotIndex = ZO_Inventory_GetBagAndIndex(inventorySlotControl)
        link = GetItemLink(bagId, slotIndex)
    end

    if link and ItemMarkerUtils:IsItemLink(link) then
        return GetItemInstanceId(bagId, slotIndex)
    end

    return nil
end

function ItemMarkerControl:GetInfoFromControl(control)
    local bagId, slotIndex

    bagId = control.dataEntry.data.bagId
    slotIndex = control.dataEntry.data.slotIndex

    return GetItemInstanceId(bagId, slotIndex)
end
