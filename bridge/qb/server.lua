if not FrameworkObj or Config.Framework ~= "qb" then return end
function GetPlayerFromId(source)
    return FrameworkObj.Functions.GetPlayer(source)
end

function GetMoney(player)
    return player.Functions.GetMoney('cash') or 0
end

function RemoveMoney(player, amount)
    player.Functions.RemoveMoney('cash', amount)
end
