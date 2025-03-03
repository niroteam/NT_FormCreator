if not FrameworkObj or (Config.Framework ~= "esx" and Config.Inventory ~= "esx") then return end

function RemoveItem(source, item, amount)
    local xPlayer = FrameworkObj.GetPlayerFromId(source)
    if not xPlayer then return end
    if item and amount > 0 then
        xPlayer.removeInventoryItem(item, amount)
    end
end

function AddItem(source, item, amount)
    local xPlayer = FrameworkObj.GetPlayerFromId(source)
    if not xPlayer then return end
    if item and amount > 0 then
        xPlayer.addInventoryItem(item, amount)
    end
end
