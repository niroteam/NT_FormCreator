if not FrameworkObj or (Config.Framework ~= "qb" and Config.Inventory ~= "qb") then return end
function RemoveItem(source, item, amount)
    local Player = FrameworkObj.Functions.GetPlayer(source)
    if not Player then return end
    if item and amount > 0 then
        Player.Functions.RemoveItem(item, amount)
    end
end

function AddItem(source, item, amount)
    local Player = FrameworkObj.Functions.GetPlayer(source)
    if not Player then return end
    if item and amount > 0 then
        Player.Functions.AddItem(item, amount)
    end
end
