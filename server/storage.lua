---@async
local function moveOutVehiclesIntoGarages()
    MySQL.update('UPDATE player_vehicles SET state = ? WHERE state = ?', {GarageVehicleState.GARAGED, GarageVehicleState.OUT})
end

---@param vehicleId integer
---@param garageName string
---@param state GarageVehicleState
---@return integer numRowsAffected
local function setVehicleGarage(vehicleId, garageName, state)
    return MySQL.update('UPDATE player_vehicles SET garage = ?, state = ? WHERE id = ?', {
        garageName,
        state,
        vehicleId
    })
end

---@param vehicleId integer
---@param impoundPrice integer
---@return integer numRowsAffected
local function setVehicleImpoundPrice(vehicleId, impoundPrice)
    return MySQL.update('UPDATE player_vehicles SET impoundPrice = ? WHERE id = ? AND state != ?', {
        impoundPrice,
        vehicleId,
        GarageVehicleState.GARAGED
    })
end

return {
    moveOutVehiclesIntoGarages = moveOutVehiclesIntoGarages,
    setVehicleGarage = setVehicleGarage,
    setVehicleImpoundPrice = setVehicleImpoundPrice,
}
