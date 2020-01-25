ItemMarker = {}

function ItemMarker:ToogleItem(itemInstanceId, inventorySlotControl)
    ItemMarkerData:ToogleItem(itemInstanceId)
    ItemMarkerControl:RefreshAll(itemInstanceId, inventorySlotControl)
end

function ItemMarker:AddMenuOption(inventorySlotControl)
    local itemInstanceId = ItemMarkerControl:GetInfoFromInventorySlotControl(inventorySlotControl)

    if itemInstanceId then
        local isItemMarked = ItemMarkerData:IsItemMarked(itemInstanceId)

        if not isItemMarked then
            zo_callLater(function ()
                AddCustomMenuItem(GetString(PanicidaStr_ItemMarker_MarkItem), function() self:ToogleItem(itemInstanceId, inventorySlotControl) end)
            end, 50)
        else
            zo_callLater(function ()
                AddCustomMenuItem(GetString(PanicidaStr_ItemMarker_UnmarkItem), function() self:ToogleItem(itemInstanceId, inventorySlotControl) end)
            end, 50)
        end
    end
end

function ItemMarker:HookPlayerInventories()
    for _, list in pairs(ItemMarkerConfig.lists) do
        if list.listView and list.listView.dataTypes and list.listView.dataTypes[1] then
            ZO_PreHook(list.listView.dataTypes[1], "setupCallback", function(control, slot)
                local itemInstanceId = ItemMarkerControl:GetInfoFromControl(control)
                if itemInstanceId then
                    ItemMarkerControl:RefreshControl(itemInstanceId, control)
                end
            end)
        end
    end
end

function ItemMarker:Initialize()
    ItemMarkerControl.libFilters:InitializeLibFilters()
    ItemMarkerData:Initialize()
    self:HookPlayerInventories()
    ZO_PreHook("ZO_InventorySlot_ShowContextMenu", function(inventorySlotControl) self:AddMenuOption(inventorySlotControl) end)
end

local function OnAddOnLoaded(eventCode, addonName)
    if addonName == ItemMarkerConfig.name then
        ItemMarker:Initialize()
    end
end


EVENT_MANAGER:RegisterForEvent(ItemMarkerConfig.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)
