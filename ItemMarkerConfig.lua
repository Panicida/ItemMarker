ItemMarkerConfig = {}

ItemMarkerConfig.name = "ItemMarker"
ItemMarkerConfig.event = "ItemMarkerEvent"
ItemMarkerConfig.savedVariablesFile = "ItemMarkerSavedVariables"
-- ItemMarkerConfig.inventories = {
--     INVENTORY_BACKPACK,
--     -- INVENTORY_GUILD_BANK,
--     -- INVENTORY_CRAFT_BAG,
--     -- INVENTORY_BANK,
--     -- INVENTORY_HOUSE_BANK
-- }
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

-- ItemMarkerConfig.filterTypes = {
--     -- LF_INVENTORY,
--     -- -- LF_BANK_WITHDRAW,
--     -- -- LF_BANK_DEPOSIT,
--     -- -- LF_GUILDBANK_WITHDRAW,
--     -- -- LF_GUILDBANK_DEPOSIT,
--     -- -- LF_SMITHING_DECONSTRUCT,
--     -- -- LF_SMITHING_IMPROVEMENT,
--     -- -- LF_ENCHANTING_CREATION,
--     -- -- LF_ENCHANTING_EXTRACTION,
--     -- LF_CRAFTBAG,
--     -- -- LF_QUICKSLOT,

--     LF_INVENTORY,
--     LF_BANK_WITHDRAW,
--     LF_BANK_DEPOSIT,
--     LF_GUILDBANK_WITHDRAW,
--     LF_GUILDBANK_DEPOSIT,
--     LF_VENDOR_BUY,
--     LF_VENDOR_SELL,
--     LF_VENDOR_BUYBACK,
--     LF_VENDOR_REPAIR,
--     LF_GUILDSTORE_BROWSE,
--     LF_GUILDSTORE_SELL,
--     LF_MAIL_SEND,
--     LF_TRADE,
--     LF_SMITHING_REFINE,
--     LF_SMITHING_CREATION,
--     LF_SMITHING_DECONSTRUCT,
--     LF_SMITHING_IMPROVEMENT,
--     LF_SMITHING_RESEARCH,
--     LF_ALCHEMY_CREATION,
--     LF_ENCHANTING_CREATION,
--     LF_ENCHANTING_EXTRACTION,
--     LF_PROVISIONING_COOK,
--     LF_PROVISIONING_BREW,
--     LF_FENCE_SELL,
--     LF_FENCE_LAUNDER,
--     LF_CRAFTBAG,
--     LF_QUICKSLOT,
--     LF_RETRAIT,
--     LF_HOUSE_BANK_WITHDRAW,
--     LF_HOUSE_BANK_DEPOSIT,
--     LF_JEWELRY_REFINE,
--     LF_JEWELRY_CREATION,
--     LF_JEWELRY_DECONSTRUCT,
--     LF_JEWELRY_IMPROVEMENT,
--     LF_JEWELRY_RESEARCH,
--     LF_SMITHING_RESEARCH_DIALOG,
--     LF_JEWELRY_RESEARCH_DIALOG,
--     LF_FILTER_MAXF_JEWELRY_RESEARCH_DIALOG,
-- }

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
