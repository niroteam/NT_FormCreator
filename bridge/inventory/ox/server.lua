if Config.Inventory ~= "ox" then return end
function RemoveItem(source, item, amount)
    if item and amount > 0 then
        exports.ox_inventory:RemoveItem(source, item, amount)
    end
end

function AddItem(source, item, amount)
    if item and amount > 0 then
        exports.ox_inventory:AddItem(source, item, amount)
    end
end
