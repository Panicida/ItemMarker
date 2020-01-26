ItemMarkerFilter = {}

local libFilters = LibFilters3

local function filterMarkItem(mark, itemInstanceId)
    local result = false
    local itemMarkInfo = ItemMarkerData:IsItemMarked(itemInstanceId)

    if mark == ItemMarkerData.KEEP_MARK and itemMarkInfo.isKeep then
        result = true
    elseif mark == ItemMarkerData.SELL_MARK and itemMarkInfo.isSell then
        result = true
    end

    return result
end

local function filterMarkKeepItemsForSlot(rawControl)
    local itemInstanceId = ItemMarkerControl:GetItemInstanceIdFromControl(rawControl)
    local isShowItem = filterMarkItem(ItemMarkerData.KEEP_MARK, itemInstanceId)
    return isShowItem
end

local function filterMarkSellItemsForSlot(rawControl)
    local itemInstanceId = ItemMarkerControl:GetItemInstanceIdFromControl(rawControl)
    local isShowItem = filterMarkItem(ItemMarkerData.SELL_MARK, itemInstanceId)
    return isShowItem
end

function ItemMarkerFilter:RequestUpdate(filter)
    libFilters:RequestUpdate(filter)
end

function ItemMarkerFilter:RegisterFilter(filterName, filterCallback)
    for _, list in pairs(ItemMarkerConfig.lists) do
        libFilters:RegisterFilter(filterName, list.filter, filterCallback)
    end
end

function ItemMarkerFilter:UnregisterFilter(filterName)
    for _, list in pairs(ItemMarkerConfig.lists) do
        libFilters:UnregisterFilter(filterName, list.filter)
    end
end

function ItemMarkerFilter:TestFilters()
    self:RegisterFilter("ItemMarker_TestFilter", filterMarkSellItemsForSlot)
    for _, list in pairs(ItemMarkerConfig.lists) do
        libFilters:RequestUpdate(list.filter)
    end
end

function ItemMarkerFilter:Initialize()
    libFilters:InitializeLibFilters()
    -- zo_callLater(function ()
    --     self:TestFilters()
    -- end, 5000)
end
