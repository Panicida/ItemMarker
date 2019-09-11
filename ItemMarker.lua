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
                AddCustomMenuItem(GetString(STR_ITEMMARKER_MARK_ITEM), function() self:ToogleItem(itemInstanceId, inventorySlotControl) end)
            end, 50)
        else
            zo_callLater(function ()
                AddCustomMenuItem(GetString(STR_ITEMMARKER_UNMARK_ITEM), function() self:ToogleItem(itemInstanceId, inventorySlotControl) end)
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
                    wololo =  wololo + 1
                    d(wololo)
                    ItemMarkerControl:RefreshControl(itemInstanceId, control)
                end
            end)
        end
    end
end

function ItemMarker:Initialize()
    wololo = 1
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

-- local function OnInventorySingleSlotUpdate(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
--     local itemInstanceId = GetInstanceId(bagId, slotIndex)
--     -- local control = 

    
--     ItemMarkerControl:RefreshControl(itemInstanceId, control)
-- end

EVENT_MANAGER:RegisterForEvent(ItemMarkerConfig.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)
-- EVENT_MANAGER:RegisterForEvent(ItemMarkerConfig.event, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, OnInventorySingleSlotUpdate)
-- EVENT_MANAGER:AddFilterForEvent(ItemMarkerConfig.event, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_BAG_ID, BAG_WORN)
-- EVENT_MANAGER:AddFilterForEvent(ItemMarkerConfig.event, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_IS_NEW_ITEM, false)
-- EVENT_MANAGER:AddFilterForEvent(ItemMarkerConfig.event, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_INVENTORY_UPDATE_REASON, INVENTORY_UPDATE_REASON_DEFAULT)






