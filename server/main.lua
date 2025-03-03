local failedAttempts = {}
local function givePrize(id)
    local src = source
    local formConfig

    for k, v in pairs(Config.Forms) do
        if k == id then
            formConfig = v
            formConfig.id = k
            break
        end
    end

    if not formConfig then
        TriggerClientEvent("ox_lib:notify", src, {
            title = "Prize Error!",
            description = "You passed but the prize could not be delivered. Contact an administrator.",
            type = "error"
        })
        return
    end


    AddItem(src, formConfig.prize, formConfig.amount)
    TriggerClientEvent("ox_lib:notify", src, {
        title = "You Passed!",
        description = "You passed the " ..
            formConfig.title .. " and got " .. formConfig.amount .. "x " .. formConfig.prize,
        type = "success"
    })
end
RegisterNetEvent("NT_FormCreator:Finalize", function(data)
    local form = Config.Forms[data.id]

    if not form or not form.questions then
        print("^1Error: Form or questions not found for ID " .. tostring(data.id))
        return
    end

    local correctAnswers = 0

    for _, answer in pairs(data.answers) do
        local rightAnswers = {}

        for _, que in pairs(form.questions) do
            for _, ans in pairs(que.answers) do
                if ans.isCorrect then
                    table.insert(rightAnswers, ans.answer)
                end
            end
        end

        for _, v in pairs(rightAnswers) do
            if answer == v then
                correctAnswers = correctAnswers + 1
            end
        end
    end

    local totalQuestions = #form.questions > 0 and #form.questions or 1
    local score = (correctAnswers / totalQuestions) * 100
    if score >= form.successPercent then
        givePrize(data.id)
    else
        TriggerClientEvent("ox_lib:notify", source, {
            title = "You Failed!",
            description = "You failed the " ..
                form.title .. " and can try again in 10 minutes.",
            type = "error"
        })
    end
end)


RegisterNetEvent("NT_FormCreator:buyForm", function(formID)
    local src = source
    local xPlayer = GetPlayerFromId(src)

    if not xPlayer then return end

    local canproceed = true
    local formConfig = Config.Forms[formID]
    if not formConfig then
        TriggerClientEvent("ox_lib:notify", src, {
            title = "Invalid Form",
            description = "This form does not exist.",
            type = "error"
        })
        return
    end

    local formPrice = formConfig.price
    local playerCash = xPlayer.getMoney()
    if playerCash >= formPrice and canproceed then
        xPlayer.removeMoney(formPrice)

        TriggerClientEvent("ox_lib:notify", src, {
            title = "Purchase Successful",
            description = "You bought the " .. formConfig.title .. " form for $" .. formPrice .. "lol",
            type = "success"
        })


        TriggerClientEvent("NT_FormCreator:GiveForm", src, formID)
    elseif playerCash < formPrice and canproceed then
        TriggerClientEvent("ox_lib:notify", src, {
            title = "Not Enough Cash",
            description = "You need $" .. formPrice .. " to buy this form.",
            type = "error"
        })
    end
end)

RegisterNetEvent("NT_FormCreator:setCooldown")
AddEventHandler("NT_FormCreator:setCooldown", function(formID)
    local playerId = source

    if not failedAttempts[playerId] then
        failedAttempts[playerId] = {}
    end

    failedAttempts[playerId][formID] = os.time()
end)
