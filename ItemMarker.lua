ItemMarker = {}

function ItemMarker:ToogleItem(mark, itemInstanceId, inventorySlotControl)
    ItemMarkerData:ToogleItem(mark, itemInstanceId)
    ItemMarkerControl:RefreshAll()
end

function ItemMarker:AddMenuOption(inventorySlotControl)
    local itemInstanceId = ItemMarkerControl:GetInfoFromInventorySlotControl(inventorySlotControl)

    if itemInstanceId then
        local itemMarkInfo = ItemMarkerData:IsItemMarked(itemInstanceId)

        if not itemMarkInfo.isKeep then
            zo_callLater(function ()
                AddCustomMenuItem(GetString(PanicidaStr_ItemMarker_MarkKeepItem), function() self:ToogleItem(ItemMarkerData.KEEP_MARK, itemInstanceId, inventorySlotControl) end)
            end, 50)
        else
            zo_callLater(function ()
                AddCustomMenuItem(GetString(PanicidaStr_ItemMarker_UnmarkKeepItem), function() self:ToogleItem(ItemMarkerData.KEEP_MARK, itemInstanceId, inventorySlotControl) end)
            end, 50)
        end

        if not itemMarkInfo.isSell then
            zo_callLater(function ()
                AddCustomMenuItem(GetString(PanicidaStr_ItemMarker_MarkSellItem), function() self:ToogleItem(ItemMarkerData.SELL_MARK, itemInstanceId, inventorySlotControl) end)
            end, 50)
        else
            zo_callLater(function ()
                AddCustomMenuItem(GetString(PanicidaStr_ItemMarker_UnmarkSellItem), function() self:ToogleItem(ItemMarkerData.SELL_MARK, itemInstanceId, inventorySlotControl) end)
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
