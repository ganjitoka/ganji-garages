---@param vehicleId integer
---@param modelName string
local function setVehicleStateToOut(vehicleId, vehicle, modelName)
    local impoundPrice = Config.calculateImpoundFee(vehicleId, modelName) or 0
    exports.qbx_vehicles:SaveVehicle(vehicle, {
        state = GarageVehicleState.OUT,
        impoundPrice = impoundPrice
    })
end

---@param player table
---@param impoundPrice integer
local function payImpoundPrice(player, impoundPrice)
    local cashBalance = player.PlayerData.money.cash
    local bankBalance = player.PlayerData.money.bank

    if cashBalance >= impoundPrice then
        player.Functions.RemoveMoney('cash', impoundPrice, 'paid-impound')
        return true
    elseif bankBalance >= impoundPrice then
        player.Functions.RemoveMoney('bank', impoundPrice, 'paid-impound')
        return true
    end
    return false
end

---@param spawnPoints table|vector4
---@return table shuffled array of spawn points
local function shuffleSpawnPoints(spawnPoints)
    if type(spawnPoints) == "vector4" then
        return {spawnPoints}
    end
    
    local shuffled = {}
    for i = 1, #spawnPoints do
        shuffled[i] = spawnPoints[i]
    end
    
    for i = #shuffled, 2, -1 do
        local j = math.random(i)
        shuffled[i], shuffled[j] = shuffled[j], shuffled[i]
    end
    
    return shuffled
end

---@param spawnCoords vector4
---@return boolean true if clear, false if occupied
local function isSpawnPointClear(spawnCoords)
    if not Config.distanceCheck then
        return true
    end
    
    local vec3Coords = vec3(spawnCoords.x, spawnCoords.y, spawnCoords.z)
    local nearbyVehicle = lib.getClosestVehicle(vec3Coords, Config.distanceCheck, false)
    return nearbyVehicle == nil
end

---@param source number
---@param vehicleId integer
---@param garageName string
---@param accessPointIndex integer
---@return number? netId
lib.callback.register('qbx_garages:server:spawnVehicle', function (source, vehicleId, garageName, accessPointIndex)
    local garage = Garages[garageName]
    local accessPoint = garage.accessPoints[accessPointIndex]
    if #(GetEntityCoords(GetPlayerPed(source)) - accessPoint.coords.xyz) > 3 then
        lib.print.error(string.format("player %s attempted to spawn a vehicle but was too far from the access point", source))
        return
    end
    local garageType = GetGarageType(garageName)

    -- Get spawn points and shuffle them
    local spawnPoints = accessPoint.spawn or accessPoint.coords
    local shuffledSpawnPoints = shuffleSpawnPoints(spawnPoints)
    
    -- Try to find a clear spawn point
    local spawnCoords = nil
    for _, coords in ipairs(shuffledSpawnPoints) do
        if isSpawnPointClear(coords) then
            spawnCoords = coords
            break
        end
    end
    
    -- If no clear spawn point found, notify and return
    if not spawnCoords then
        Notify(locale('error.no_space'), 'error')
        return
    end

    local filter = GetPlayerVehicleFilter(source, garageName)
    local playerVehicle = exports.qbx_vehicles:GetPlayerVehicle(vehicleId, filter)
    if not playerVehicle then
        Notify(locale('error.not_owned'), 'error')
        return
    end
    if garageType == GarageType.IMPOUND and FindPlateOnServer(playerVehicle.props.plate) then -- If impound, check if vehicle is not already spawned on the map
        return Notify(locale('error.not_impound'), 'error', 5000)
    end

    if garageType == GarageType.IMPOUND and playerVehicle.impoundPrice and playerVehicle.impoundPrice > 0 then
        local player = exports.qbx_core:GetPlayer(source)
        local canPay = payImpoundPrice(player, playerVehicle.impoundPrice)

        if not canPay then
            Notify(locale('error.not_enough'), 'error')
            return
        end
    end

    local warpPed = Config.warpInVehicle and GetPlayerPed(source)
    local netId, veh = qbx.spawnVehicle({ spawnSource = spawnCoords, model = playerVehicle.props.model, props = playerVehicle.props, warp = warpPed})

    if Config.doorsLocked then
        TriggerEvent('qb-vehiclekeys:server:setVehLockState', netId, 2)
    end

    TriggerClientEvent('vehiclekeys:client:SetOwner', source, playerVehicle.props.plate)

    Entity(veh).state:set('vehicleid', vehicleId, false)
    setVehicleStateToOut(vehicleId, veh, playerVehicle.modelName)
    TriggerEvent('qbx_garages:server:vehicleSpawned', veh)
    return netId
end)
