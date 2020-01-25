ItemMarkerConfig = {}

ItemMarkerConfig.name = "ItemMarker"
ItemMarkerConfig.version = "0.0.1"
ItemMarkerConfig.event = "ItemMarkerEvent"
ItemMarkerConfig.savedVariablesFile = "ItemMarkerSavedVariables"

ItemMarkerConfig.lists = {
    -- Backpack
    [SLOT_TYPE_ITEM] = {
        listView = ZO_PlayerInventoryList,
        filter = LF_INVENTORY
    },
    -- Craftbag
    [SLOT_TYPE_CRAFT_BAG_ITEM] = {
        listView = ZO_CraftBagList,
        filter = LF_CRAFTBAG
    },
    -- DECONSTRUCTION = {
    --     listView = ZO_SmithingTopLevelDeconstructionPanelInventoryBackpack,
    --     filter = 
    -- }

    -- BACKPACK = ZO_PlayerInventoryList,
    -- QUICKSLOT = ZO_QuickSlotList,
    -- BANK = ZO_PlayerBankBackpack,
    -- GUILD_BANK = ZO_GuildBankBackpack,
    -- IMPROVEMENT = ZO_SmithingTopLevelImprovementPanelInventoryBackpack,
    -- ENCHANTING = ZO_EnchantingTopLevelInventoryBackpack,
    -- ALCHEMY = ZO_AlchemyTopLevelInventoryBackpack,
    -- LIST_DIALOG = ZO_ListDialog1List,
}

-- ItemMarkerConfig.slotTypes = {
--     [SLOT_TYPE_ITEM] = true,
    -- [SLOT_TYPE_EQUIPMENT] = true,
    -- [SLOT_TYPE_STORE_BUY] = true,
    -- [SLOT_TYPE_STORE_BUYBACK] = true,
    -- [SLOT_TYPE_BANK_ITEM] = true,
    -- [SLOT_TYPE_GUILD_BANK_ITEM] = true,
    -- [SLOT_TYPE_LOOT] = true,
    -- [SLOT_TYPE_CRAFTING_COMPONENT] = true,
    -- [SLOT_TYPE_PENDING_CRAFTING_COMPONENT] = true,
    -- [SLOT_TYPE_CRAFT_BAG_ITEM] = true
-- }
