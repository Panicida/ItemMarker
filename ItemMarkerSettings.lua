ItemMarkerSettings = {}


local LAM = LibAddonMenu2
local panelName = "ItemMarkerSettingsPanel"
local panelData = {
    type = "panel",
    name = "Item Marker",
    author = "Panicida",
    version = ItemMarkerConfig.version
}

local textureChoices = {
    ItemMarkerControl.texturePaths[ItemMarkerConstants.textures.star],
    ItemMarkerControl.texturePaths[ItemMarkerConstants.textures.sell],
    ItemMarkerControl.texturePaths[ItemMarkerConstants.textures.lock],
    ItemMarkerControl.texturePaths[ItemMarkerConstants.textures.forbidden]
}

local optionsData = {
    {
        type = "header",
        name = "Style",
        width = "full",
    },
    {
        type = "iconpicker",
        name = "Keep icon",
        choices = textureChoices,
        getFunc = function() return GetTexturePath(ItemMarkerData.KEEP_MARK) end,
        setFunc = function(texturePath) SetTexturePath(ItemMarkerData.KEEP_MARK, texturePath) end,
        choicesTooltips = textureChoices,
        maxColumns = 5,
        visibleRows = 6,
        iconSize = 24,
        width = "full"
    },
    {
        type = "iconpicker",
        name = "Sell icon",
        choices = textureChoices,
        getFunc = function() return GetTexturePath(ItemMarkerData.SELL_MARK) end,
        setFunc = function(texturePath) SetTexturePath(ItemMarkerData.SELL_MARK, texturePath) end,
        choicesTooltips = textureChoices,
        maxColumns = 5,
        visibleRows = 6,
        iconSize = 24,
        width = "full"
    }
}

function GetTexturePath(mark)
    return ItemMarkerControl.texturePaths[ItemMarkerData:GetTexture(mark)]
end

function SetTexturePath(mark, texturePath)
    local texture
    for key, value in pairs(ItemMarkerControl.texturePaths) do
        if texturePath == value then
            texture = key
            break
        end
    end
    
    if texture then
        ItemMarkerData:SetTexture(mark, texture)
        ItemMarkerControl:RefreshAll()
    end
end

function ItemMarkerSettings:Initialize()
    LAM:RegisterAddonPanel(panelName, panelData)
    LAM:RegisterOptionControls(panelName, optionsData)
end
