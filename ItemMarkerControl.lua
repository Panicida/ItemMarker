ItemMarkerControl = {}

ItemMarkerControl.markerName = "ItemMarker"

function ItemMarkerControl:RefreshControl(itemInstanceId, inventorySlot)
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
    local control = inventorySlot:GetNamedChild(self.markerName)

    if control and not isItemMarked then
        control:SetHidden(true)
        return
    elseif not isItemMarked then
        return
    end

    if not control then
        control = WINDOW_MANAGER:CreateControl(inventorySlot:GetName() .. ItemMarkerControl.markerName, inventorySlot, CT_TEXTURE)
        control:SetDimensions(32, 32)
        control:SetDrawTier(DT_HIGH)
    end

    local texturePath, r, g, b = ItemMarkerData:GetMarkerInfo(itemInstanceId)
    local markerAnchor = ItemMarkerData:GetMarkerAnchor()
    local anchorTarget = inventorySlot:GetNamedChild("Button")
    local offsetX, offsetY = getMarkerAnchorOffsets(markerAnchor)

    if anchorTarget then
        --list control
        anchorTarget = anchorTarget:GetNamedChild("Icon")
    else
        --equipment control
        anchorTarget = inventorySlot:GetNamedChild("Icon")
    end

    --there's no anchor target. How'd we get here?
    if not anchorTarget then return end

    control:SetHidden(false)
    control:SetTexture(texturePath)
    control:SetColor(r, g, b)
    control:ClearAnchors()
    control:SetAnchor(markerAnchor, anchorTarget, markerAnchor, offsetX, offsetY)    
end
