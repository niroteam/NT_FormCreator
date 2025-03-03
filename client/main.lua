local spawnedPed = nil

local function openFormMenu()
    local formOptions = {}

    for formID, form in pairs(Config.Forms) do
        table.insert(formOptions, {
            title = form.title .. " ($" .. form.price .. ")",
            description = "Take the " .. form.title .. " form.",
            icon = "fa-solid fa-file",
            onSelect = function()
                TriggerServerEvent("NT_FormCreator:buyForm", formID)
            end
        })
    end

    lib.registerContext({
        id = "form_menu",
        title = "Buy a Form",
        options = formOptions
    })

    lib.showContext("form_menu")
end

local function spawnPed()
    local model = Config.Store.npc
    local coords = Config.Store.location

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(500)
    end

    spawnedPed = CreatePed(4, model, coords.x, coords.y, coords.z, 0.0, false, false)
    SetEntityHeading(spawnedPed, 0.0)
    FreezeEntityPosition(spawnedPed, true)
    SetEntityInvincible(spawnedPed, true)
    SetBlockingOfNonTemporaryEvents(spawnedPed, true)
    TaskStandStill(spawnedPed, -1)

    exports.ox_target:addLocalEntity(spawnedPed, {
        {
            name = "buy_form",
            icon = "fa-solid fa-file-signature",
            label = "Buy Form",
            onSelect = function()
                openFormMenu()
            end,
            distance = 2.0
        }
    })
end

CreateThread(function()
    Wait(0)
    spawnPed()
end)

RegisterCommand('testquestionare', function(_, args, rawCommand)
    local data
    for k, v in pairs(Config.Forms) do
        print(k)
        if k == args[1] then
            data = v
            data.id = k
            break
        end
    end
    SendNUIMessage({
        type = 'startQustionare',
        data = data
    })
    SetNuiFocus(true, true)
end, false)

RegisterNuiCallback('notify', function(info, cb)
    local data = {
        type = info.type,
        title = info.title
    }
    lib.notify(data)
    cb("ok")
end)
RegisterNUICallback('hideMessage', function(_, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)
RegisterNUICallback('quizEnd', function(data, cb)
    SetNuiFocus(false, false)
    TriggerServerEvent("NT_FormCreator:Finalize", data)
end)

RegisterNetEvent("NT_FormCreator:GiveForm", function(formID)
    local data
    for k, v in pairs(Config.Forms) do
        if k == formID then
            data = v
            data.id = k
            break
        end
    end
    SendNUIMessage({
        type = 'startQustionare',
        data = data
    })
    SetNuiFocus(true, true)
end)
AddEventHandler("onResourceStart", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        SendNUIMessage({
            type = "hideMessage"
        })
        SetNuiFocus(false, false)
    end
end)
