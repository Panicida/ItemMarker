ItemMarkerConfig = {}

ItemMarkerConfig.name = "ItemMarker"
ItemMarkerConfig.event = "ItemMarkerEvent"
ItemMarkerConfig.savedVariablesFile = "ItemMarkerSavedVariables"
ItemMarkerConfig.inventories = {
    INVENTORY_BACKPACK,
    -- INVENTORY_GUILD_BANK,
    -- INVENTORY_CRAFT_BAG,
    -- INVENTORY_BANK,
    -- INVENTORY_HOUSE_BANK
}
ItemMarkerConfig.markersInfo = {
    star = [[/esoui/art/campaign/overview_indexicon_bonus_disabled.dds]]
}

ItemMarkerConfig.filterTypes = {
    LF_INVENTORY,
    -- LF_BANK_WITHDRAW,
    -- LF_BANK_DEPOSIT,
    -- LF_GUILDBANK_WITHDRAW,
    -- LF_GUILDBANK_DEPOSIT,
    -- LF_SMITHING_DECONSTRUCT,
    -- LF_SMITHING_IMPROVEMENT,
    -- LF_ENCHANTING_CREATION,
    -- LF_ENCHANTING_EXTRACTION,
    -- LF_CRAFTBAG,
    -- LF_QUICKSLOT
}

ItemMarkerConfig.slotTypes = {
    [SLOT_TYPE_ITEM] = true,
    -- SLOT_TYPE_EQUIPMENT,
    -- SLOT_TYPE_STORE_BUY,
    -- SLOT_TYPE_STORE_BUYBACK,
    -- SLOT_TYPE_BANK_ITEM,
    -- SLOT_TYPE_GUILD_BANK_ITEM,
    -- SLOT_TYPE_LOOT,
    -- SLOT_TYPE_CRAFTING_COMPONENT,
    -- SLOT_TYPE_PENDING_CRAFTING_COMPONENT,
    -- SLOT_TYPE_CRAFT_BAG_ITEM
}
