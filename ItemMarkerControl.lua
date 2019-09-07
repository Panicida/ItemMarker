ItemMarkerControl = {}

ItemMarkerControl.markerName = "ItemMarker"

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

    local isItemMarked = ItemMarkerData:IsItemMarked(itemInstanceId)
    local markerControl = control:GetNamedChild(self.markerName)

    if markerControl and not isItemMarked then
        markerControl:SetHidden(true)
        return
    elseif not isItemMarked then
        return
    end

    if not markerControl then
        markerControl = WINDOW_MANAGER:CreateControl(control:GetName() .. ItemMarkerControl.markerName, control, CT_TEXTURE)
        markerControl:SetDimensions(32, 32)
        markerControl:SetDrawTier(DT_HIGH)
    end

    local texturePath, r, g, b = ItemMarkerData:GetMarkerInfo(itemInstanceId)
    local markerAnchor = ItemMarkerData:GetMarkerAnchor()
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
    if not anchorTarget then return end

    markerControl:SetHidden(false)
    markerControl:SetTexture(texturePath)
    markerControl:SetColor(r, g, b)
    markerControl:ClearAnchors()
    markerControl:SetAnchor(markerAnchor, anchorTarget, markerAnchor, offsetX, offsetY)    
end

function ItemMarkerControl:GetInfoFromInventorySlotControl(inventorySlotControl)
    local bagId, slotIndex
    local link = nil
    local slotType = ZO_InventorySlot_GetType(inventorySlotControl)

    if slotType == SLOT_TYPE_ITEM or
       slotType == SLOT_TYPE_EQUIPMENT or
       slotType == SLOT_TYPE_STORE_BUY or
       slotType == SLOT_TYPE_STORE_BUYBACK or
       slotType == SLOT_TYPE_BANK_ITEM or
       slotType == SLOT_TYPE_GUILD_BANK_ITEM or
       slotType == SLOT_TYPE_LOOT or
       slotType == SLOT_TYPE_CRAFTING_COMPONENT or
       slotType == SLOT_TYPE_PENDING_CRAFTING_COMPONENT or
       slotType == SLOT_TYPE_CRAFT_BAG_ITEM then
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
