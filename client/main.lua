local config = require 'config.client'
local VEHICLES = exports.qbx_core:GetVehiclesByName()

local VehicleCategory = {
    all = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22},
    car = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 17, 18, 19, 20, 22},
    air = {15, 16},
    sea = {14},
}

---@param category GarageVehicleType
---@param vehicle number
---@return boolean
local function isOfType(category, vehicle)
    local classSet = {}

    for _, class in pairs(VehicleCategory[category]) do
        classSet[class] = true
    end

    return classSet[GetVehicleClass(vehicle)] == true
end

---@param vehicle number
local function kickOutPeds(vehicle)
    for i = -1, 5, 1 do
        local seat = GetPedInVehicleSeat(vehicle, i)
        if seat then
            TaskLeaveVehicle(seat, vehicle, 0)
        end
    end
end

local spawnLock = false

---@param vehicleId number
---@param garageName string
---@param accessPoint integer
---@return boolean success
function takeOutOfGarage(vehicleId, garageName, accessPoint)
    if spawnLock then
        Notify(locale('error.spawn_in_progress'), 'error')
        return false
    end
    spawnLock = true
    local success, result = pcall(function()
        if cache.vehicle then
            Notify(locale('error.in_vehicle'), 'error')
            return false
        end

        local netId = lib.callback.await('qbx_garages:server:spawnVehicle', false, vehicleId, garageName, accessPoint)
        if not netId then 
            Notify('Failed to spawn vehicle', 'error')
            return false
        end

        local veh = lib.waitFor(function()
            if NetworkDoesEntityExistWithNetworkId(netId) then
                return NetToVeh(netId)
            end
        end)

        if veh == 0 then
            Notify('Something went wrong spawning the vehicle', 'error')
            return false
        end

        if config.engineOn then
            SetVehicleEngineOn(veh, true, true, false)
        end
        
        Notify('Vehicle spawned successfully', 'success')
        return true
    end)
    spawnLock = false
    
    if not success then
        return false
    end
    
    return result or false
end

---@param vehicle number
---@param garageName string
local function parkVehicle(vehicle, garageName)
    if GetVehicleNumberOfPassengers(vehicle) ~= 1 then
        local isParkable = lib.callback.await('qbx_garages:server:isParkable', false, garageName, NetworkGetNetworkIdFromEntity(vehicle))

        if not isParkable then
            Notify(locale('error.not_owned'), 'error', 5000)
            return
        end

        kickOutPeds(vehicle)
        SetVehicleDoorsLocked(vehicle, 2)
        Wait(1500)
        lib.callback.await('qbx_garages:server:parkVehicle', false, NetworkGetNetworkIdFromEntity(vehicle), lib.getVehicleProperties(vehicle), garageName)
        Notify(locale('success.vehicle_parked'), 'success', 4500)
    else
        Notify(locale('error.vehicle_occupied'), 'error', 3500)
    end
end

---@param garage GarageConfig
---@return boolean
local function checkCanAccess(garage)
    if garage.groups and not exports.qbx_core:HasPrimaryGroup(garage.groups, QBX.PlayerData) then
        Notify(locale('error.no_access'), 'error')
        return false
    end
    if cache.vehicle and not isOfType(garage.garageVehicleType, cache.vehicle) then
        Notify(locale('error.not_correct_type'), 'error')
        return false
    end
    return true
end

---@param garageName string
---@param garage GarageConfig
---@param accessPoint AccessPoint
---@param accessPointIndex integer
local function createZones(garageName, garage, accessPoint, accessPointIndex)
    CreateThread(function()
        local dropPoints = accessPoint.dropPoint or accessPoint.spawn
        local dropPointsArray = {}
        if dropPoints and type(dropPoints) == "vector4" then
            dropPointsArray = {dropPoints}
        elseif dropPoints and type(dropPoints) == "table" and #dropPoints > 0 then
            dropPointsArray = dropPoints
        end

        local dropZones = {}
        local coordsZone
        lib.zones.sphere({
            coords = accessPoint.coords,
            radius = 45,
            onEnter = function()
                if dropPointsArray and #dropPointsArray > 0 and garage.type ~= GarageType.IMPOUND then
                    for i=1,#dropPointsArray do
                        dropZones[i] = lib.zones.sphere({
                            coords = vec3(dropPointsArray[i].x, dropPointsArray[i].y, dropPointsArray[i].z),
                            radius = 2.5,
                            onEnter = function()
                                if not cache.vehicle then return end
                                lib.showTextUI(locale('info.park_e') or "")
                            end,
                            onExit = function()
                                lib.hideTextUI()
                            end,
                            inside = function()
                                if not cache.vehicle then return end
                                if IsControlJustReleased(0, 38) then
                                    if not checkCanAccess(garage) then return end
                                    parkVehicle(cache.vehicle, garageName)
                                end
                            end,
                            debug = config.debugPoly
                        })
                    end
                end
                coordsZone = lib.zones.sphere({
                    coords = accessPoint.coords,
                    radius = 2.5,
                    onEnter = function()
                        if accessPoint.dropPoint and cache.vehicle then return end
                        lib.showTextUI((garage.type == GarageType.IMPOUND and (locale('info.impound_e') or "")) or (cache.vehicle and (locale('info.park_e') or "")) or (locale('info.car_e') or ""))
                    end,
                    onExit = function()
                        lib.hideTextUI()
                    end,
                    inside = function()
                        if accessPoint.dropPoint and cache.vehicle then return end
                        if IsControlJustReleased(0, 38) then
                            if not checkCanAccess(garage) then return end
                            if cache.vehicle and garage.type ~= GarageType.IMPOUND then
                                parkVehicle(cache.vehicle, garageName)
                            elseif not cache.vehicle then
                                OpenReactGarageUI(garageName, garage, accessPointIndex)
                            end
                        end
                    end,
                    debug = config.debugPoly
                })
            end,
            onExit = function()
                if dropZones then
                    for _, zone in ipairs(dropZones) do
                        zone:remove()
                    end
                end
                if coordsZone then
                    coordsZone:remove()
                end
            end,
            inside = function()
                if cache.vehicle then
                    if accessPoint.dropPoint then
                        config.drawDropOffMarker(accessPoint.dropPoint, garage.garageVehicleType)
                    end
                    if dropPointsArray and #dropPointsArray > 0 and garage.type ~= GarageType.IMPOUND then
                        for i=1,#dropPointsArray do
                            config.drawDropOffMarker(vec3(dropPointsArray[i].x, dropPointsArray[i].y, dropPointsArray[i].z), garage.garageVehicleType)
                        end
                    end
                end
                config.drawGarageMarker(accessPoint.coords.xyz, garage.garageVehicleType)
            end,
            debug = config.debugPoly,
        })
    end)
end

---@param garageName string
---@param accessPoint AccessPoint
local function createBlips(garageName, accessPoint)
    local blip = AddBlipForCoord(accessPoint.coords.x, accessPoint.coords.y, accessPoint.coords.z)
    SetBlipSprite(blip, accessPoint.blip.sprite or 357)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.60)
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, accessPoint.blip.color or 3)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(accessPoint.blip.name or garageName)
    EndTextCommandSetBlipName(blip)
end

local function createGarage(name, garage)
    local accessPoints = garage.accessPoints
    for i = 1, #accessPoints do
        local accessPoint = accessPoints[i]

        if accessPoint.blip then
            createBlips(name, accessPoint)
        end

        createZones(name, garage, accessPoint, i)
    end
end

local function createGarages()
    local garages = lib.callback.await('qbx_garages:server:getGarages')
    for name, garage in pairs(garages) do
        createGarage(name, garage)
    end
end

RegisterNetEvent('qbx_garages:client:garageRegistered', function(name, garage)
    createGarage(name, garage)
end)

-- Vehicle fade effect function
local function fadeVehicle(vehicle, duration)
    local startTime = GetGameTimer()
    local endTime = startTime + duration
    
    CreateThread(function()
        while GetGameTimer() < endTime do
            local currentTime = GetGameTimer()
            local progress = (currentTime - startTime) / duration
            local alpha = math.floor(255 * (1 - progress))
            
            if DoesEntityExist(vehicle) then
                SetEntityAlpha(vehicle, alpha, false)
            else
                break
            end
            
            Wait(16) -- ~60 FPS
        end
        
        -- Ensure vehicle is fully transparent at the end
        if DoesEntityExist(vehicle) then
            SetEntityAlpha(vehicle, 0, false)
        end
    end)
end

-- Event handler for vehicle fade
RegisterNetEvent('qbx_garages:client:fadeVehicle', function(netId)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if vehicle and DoesEntityExist(vehicle) then
        fadeVehicle(vehicle, 2000) -- 2 second fade
    end
end)

CreateThread(function()
    createGarages()
end)
