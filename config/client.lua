return {
    engineOn = false, -- If true, the engine will be on upon taking the vehicle out.
    debugPoly = false,

    --- called every frame when player is near the garage and there is a separate drop off marker
    ---@param coords vector3
    ---@param type GarageVehicleType
    drawDropOffMarker = function(coords, type)
        local markerType = 0
        if type == GarageVehicleType.CAR then
            markerType = 36
        elseif type == GarageVehicleType.AIR then
            markerType = 34
        elseif type == GarageVehicleType.SEA then
            markerType = 35
        end
---@diagnostic disable-next-line: param-type-mismatch
        DrawMarker(markerType, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 242, 0, 48, 255, true, true, 2, false, nil, nil, false)
    end,

    --- called every frame when player is near the garage to draw the garage marker
    ---@param coords vector3
    ---@param type GarageVehicleType
    drawGarageMarker = function(coords, type)
        local markerType = 0
        if type == GarageVehicleType.CAR then
            markerType = 36
        elseif type == GarageVehicleType.AIR then
            markerType = 34
        elseif type == GarageVehicleType.SEA then
            markerType = 35
        end
---@diagnostic disable-next-line: param-type-mismatch
        DrawMarker(markerType, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 20, 246, 12, 255, true, true, 2, false, nil, nil, false)
    end,
}
