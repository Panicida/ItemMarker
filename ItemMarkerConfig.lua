ItemMarkerConfig = {}

ItemMarkerConfig.name = "ItemMarker"
ItemMarkerConfig.event = "ItemMarkerEvent"
ItemMarkerConfig.savedVariablesFile = "ItemMarkerSavedVariables"
ItemMarkerConfig.markersInfo = {
    star = [[/esoui/art/campaign/overview_indexicon_bonus_disabled.dds]]
}

ItemMarkerConfig.lists = {
    BACKPACK = {
        listView = ZO_PlayerInventoryList,
        filter = LF_INVENTORY
    },

    -- BACKPACK = ZO_PlayerInventoryList,
    -- QUICKSLOT = ZO_QuickSlotList,
    -- BANK = ZO_PlayerBankBackpack,
    -- GUILD_BANK = ZO_GuildBankBackpack,
    -- CRAFTBAG = ZO_CraftBagList,
    -- DECONSTRUCTION = ZO_SmithingTopLevelDeconstructionPanelInventoryBackpack,
    -- IMPROVEMENT = ZO_SmithingTopLevelImprovementPanelInventoryBackpack,
    -- ENCHANTING = ZO_EnchantingTopLevelInventoryBackpack,
    -- ALCHEMY = ZO_AlchemyTopLevelInventoryBackpack,
    -- LIST_DIALOG = ZO_ListDialog1List,
}

ItemMarkerConfig.slotTypes = {
    [SLOT_TYPE_ITEM] = true,
    -- [SLOT_TYPE_EQUIPMENT] = true,
    -- [SLOT_TYPE_STORE_BUY] = true,
    -- [SLOT_TYPE_STORE_BUYBACK] = true,
    -- [SLOT_TYPE_BANK_ITEM] = true,
    -- [SLOT_TYPE_GUILD_BANK_ITEM] = true,
    -- [SLOT_TYPE_LOOT] = true,
    -- [SLOT_TYPE_CRAFTING_COMPONENT] = true,
    -- [SLOT_TYPE_PENDING_CRAFTING_COMPONENT] = true,
    [SLOT_TYPE_CRAFT_BAG_ITEM] = true
}
