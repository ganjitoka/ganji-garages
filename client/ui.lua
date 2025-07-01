local config = require 'config.client'

local isUIOpen = false
local currentGarage = nil

-- NUI Callbacks
RegisterNUICallback('closeGarage', function(data, cb)
    SetNuiFocus(false, false)
    isUIOpen = false
    currentGarage = nil
    cb('ok')
end)

RegisterNUICallback('takeOutVehicle', function(data, cb)
    if not currentGarage then return cb('error') end
    
    local vehicleId = tonumber(data.vehicleId)
    if not vehicleId then 
        Notify('Invalid vehicle ID', 'error')
        return cb('error') 
    end
    
    -- Use the proper takeOutOfGarage function that has all the client-side logic
    local success = takeOutOfGarage(vehicleId, currentGarage.name, currentGarage.accessPoint)
    
    -- Only close the garage UI if vehicle spawn was successful
    if success then
        SetNuiFocus(false, false)
        isUIOpen = false
        SendNUIMessage({
            type = 'HIDE_GARAGE'
        })
        currentGarage = nil
    end
    
    cb('ok')
end)

RegisterNUICallback('lendVehicle', function(data, cb)
    local vehicleId = data.vehicleId
    -- Implement lending logic here
    Notify('Vehicle lending feature coming soon!', 'info')
    cb('ok')
end)

RegisterNUICallback('giveVehicle', function(data, cb)
    local vehicleId = data.vehicleId
    -- Implement giving logic here
    Notify('Vehicle giving feature coming soon!', 'info')
    cb('ok')
end)

RegisterNUICallback('sellVehicle', function(data, cb)
    local vehicleId = data.vehicleId
    -- Implement selling logic here
    Notify('Vehicle selling feature coming soon!', 'info')
    cb('ok')
end)

-- Function to get garage icon type
local function getGarageType(garageInfo)
    if garageInfo.garageVehicleType == 'car' then
        return 'car'
    elseif garageInfo.garageVehicleType == 'air' then
        return 'air'
    elseif garageInfo.garageVehicleType == 'sea' then
        return 'sea'
    elseif garageInfo.type == 'IMPOUND' then
        return 'impound'
    else
        return 'car'
    end
end

-- Function to format vehicle data for React UI
local function formatVehicleForUI(vehicleEntity)
    local vehicle = vehicleEntity.vehicle
    local props = vehicleEntity.props
    local vehicleData = exports.qbx_core:GetVehiclesByName()[vehicleEntity.modelName]
    
    return {
        id = tostring(vehicleEntity.id),
        name = ('%s %s'):format(vehicleData.brand or 'Unknown', vehicleData.name or vehicleEntity.modelName),
        model = vehicleEntity.modelName,
        plate = props.plate or 'UNKNOWN',
        fuel = math.floor((props.fuelLevel or 100) * 100 / 100),
        engine = math.floor((props.engineHealth or 1000) * 100 / 1000),
        body = math.floor((props.bodyHealth or 1000) * 100 / 1000),
        stats = {
            maxSpeed = math.random(70, 100), -- Replace with actual vehicle stats
            acceleration = math.random(60, 95),
            braking = math.random(50, 90),
            traction = math.random(60, 90),
            suspension = math.random(50, 85),
        },
        garage = vehicleEntity.garageId or 'Unknown',
        state = vehicleEntity.state or 'GARAGED',
    }
end

-- Function to open React garage UI
function OpenReactGarageUI(garageName, garageInfo, accessPoint)
    local vehicleEntities = lib.callback.await('qbx_garages:server:getGarageVehicles', false, garageName)
    
    table.sort(vehicleEntities, function(a, b)
        return a.modelName < b.modelName
    end)

    local vehicles = {}
    for i = 1, #vehicleEntities do
        vehicles[#vehicles + 1] = formatVehicleForUI(vehicleEntities[i])
    end

    local garageData = {
        name = garageName,
        type = getGarageType(garageInfo),
        vehicles = vehicles,
        totalCount = #vehicles,
    }

    currentGarage = {
        name = garageName,
        info = garageInfo,
        accessPoint = accessPoint,
    }

    SetNuiFocus(true, true)
    isUIOpen = true
    
    SendNUIMessage({
        type = 'UPDATE_GARAGE_DATA',
        data = garageData
    })
end

-- Close UI on resource stop
AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        if isUIOpen then
            SetNuiFocus(false, false)
            isUIOpen = false
        end
    end
end)

-- Close UI on ESC key
RegisterCommand('+garage_close', function()
    if isUIOpen then
        SetNuiFocus(false, false)
        isUIOpen = false
        currentGarage = nil
    end
end, false)

RegisterKeyMapping('+garage_close', 'Close Garage UI', 'keyboard', 'ESCAPE')
