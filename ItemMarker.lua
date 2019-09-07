ItemMarker = {}

ItemMarker.name = "ItemMarker"
ItemMarker.event = "ItemMarkerEvent"
ItemMarker.savedVariablesFile = "ItemMarkerSavedVariables"
ItemMarker.slotsLists = {
    BACKPACK = ZO_PlayerInventoryList,
    CRAFTBAG = ZO_CraftBagList
}

ItemMarker.inventories = {
    1
}

-- local LISTS = {
--     BACKPACK = ZO_PlayerInventoryList,
--     QUICKSLOT = ZO_QuickSlotList,
--     BANK = ZO_PlayerBankBackpack,
--     GUILD_BANK = ZO_GuildBankBackpack,
--     CRAFTBAG = ZO_CraftBagList,
--     DECONSTRUCTION = ZO_SmithingTopLevelDeconstructionPanelInventoryBackpack,
--     IMPROVEMENT = ZO_SmithingTopLevelImprovementPanelInventoryBackpack,
--     ENCHANTING = ZO_EnchantingTopLevelInventoryBackpack,
--     ALCHEMY = ZO_AlchemyTopLevelInventoryBackpack,
--     LIST_DIALOG = ZO_ListDialog1List,
-- }

function ItemMarker:ToogleItem(itemInstanceId, inventorySlot)
    ItemMarkerData:ToogleItem(itemInstanceId)
    ItemMarkerControl:RefreshControl(itemInstanceId, inventorySlot)
end

function ItemMarker:AddMenuOption(control)
    local bag, index
    local link = nil
    local slotType = ZO_control_GetType(control)
    
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
        bag, index = ZO_Inventory_GetBagAndIndex(control)
        link = GetItemLink(bag, index)
    end

    if link and ItemMarkerUtils:IsItemLink(link) then
        local itemInstanceId = GetItemInstanceId(bag, index)
        local isItemMarked = ItemMarkerData:IsItemMarked(itemInstanceId)

        if not isItemMarked then
            zo_callLater(function ()
                AddCustomMenuItem(GetString(STR_ITEMMARKER_MARK_ITEM), function() self:ToogleItem(itemInstanceId, control) end)
            end, 50)
        else
            zo_callLater(function ()
                AddCustomMenuItem(GetString(STR_ITEMMARKER_UNMARK_ITEM), function() self:ToogleItem(itemInstanceId, control) end)
            end, 50)
        end
    end
end

-- function ItemMarker:HookBags()
--     -- PLAYER_INVENTORY (backpack/quest_item/bank/house_bank/guild_bank/craft_bag)
--     for k,v in pairs(PLAYER_INVENTORY.inventories) do
--       local listView = v.listView
--       if ( listView and listView.dataTypes and listView.dataTypes[1] ) then
--         ZO_PreHook(listView.dataTypes[1], "setupCallback", function(control, slot)
--           local itemLink = GetItemLink(control.dataEntry.data.bagId, control.dataEntry.data.slotIndex, LINK_STYLE_BRACKETS)
--           self:SetInventoryIcon(control, itemLink)
--         end)
--       end
--     end
-- end


-- local hookedSetupFunctions = {}
--     local function newSetupCallback(rowControl, slot)
--         local listViewName = rowControl:GetParent():GetParent():GetName()

--         if hookedSetupFunctions[listViewName] then
--             hookedSetupFunctions[listViewName](rowControl, slot)
--         end

--         util.CreateMarkerControl(rowControl)
--     end

--     --list hooks
--     for _, list in pairs(LISTS) do
--         hookedSetupFunctions[list:GetName()] = list.dataTypes[1].setupCallback
--         list.dataTypes[1].setupCallback = newSetupCallback
--     end

function ItemMarker:HookControls()
    local slotType = ZO_control_GetType(control)
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
        bag, index = ZO_Inventory_GetBagAndIndex(control)
        link = GetItemLink(bag, index)
    end

    for inventoryType, inventory in pairs(PLAYER_INVENTORY.inventories) do
        if self.inventories[inventoryType] and
           inventory.listView and inventory.listView.dataTypes and inventory.listView.dataTypes[1] then
            ZO_PreHook(listView.dataTypes[1], "setupCallback", function(control, slot)
                local itemInstanceId = GetInstanceId(control.dataEntry.data.bagId, control.dataEntry.data.slotIndex)
                self:RefreshControl(itemInstanceId, control)
            end)
        end
        -- https://www.esoui.com/forums/archive/index.php/t-2182.html
    end
end

function ItemMarker:Initialize()
    ItemMarkerData:Initialize()
    -- self:HookControls()
    ZO_PreHook("ZO_control_ShowContextMenu", function(control) self:AddMenuOption(control) end)
end

local function OnAddOnLoaded(eventCode, addonName)
    if addonName == ItemMarker.name then
        ItemMarker:Initialize()
    end
end

-- local function OnInventorySingleSlotUpdate(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
--     local itemInstanceId = GetInstanceId(bagId, slotIndex)
--     -- local control = 

    
--     ItemMarkerControl:RefreshControl(itemInstanceId, control)
-- end

EVENT_MANAGER:RegisterForEvent(ItemMarker.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)
-- EVENT_MANAGER:RegisterForEvent(ItemMarker.event, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, OnInventorySingleSlotUpdate)
-- EVENT_MANAGER:AddFilterForEvent(ItemMarker.event, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_BAG_ID, BAG_WORN)
-- EVENT_MANAGER:AddFilterForEvent(ItemMarker.event, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_IS_NEW_ITEM, false)
-- EVENT_MANAGER:AddFilterForEvent(ItemMarker.event, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_INVENTORY_UPDATE_REASON, INVENTORY_UPDATE_REASON_DEFAULT)






