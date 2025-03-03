if not FrameworkObj or Config.Framework ~= "esx" then return end
function GetPlayerFromId(source)
    return FrameworkObj.GetPlayerFromId(source)
end

function GetMoney(player)
    return player.getMoney() or 0
end

function RemoveMoney(player, amount)
    player.removeMoney(amount)
end
