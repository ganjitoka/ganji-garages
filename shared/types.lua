---@class GarageBlip
---@field name? string -- Name of the blip. Defaults to garage label.
---@field sprite? number -- Sprite for the blip. Defaults to 357
---@field color? number -- Color for the blip. Defaults to 3.

---The place where the player can access the garage and spawn a car
---@class AccessPoint
---@field coords vector3 where the garage menu can be accessed from
---@field blip? GarageBlip
---@field spawn? vector4 | vector4[] where the vehicle will spawn. Defaults to coords. Singe coords will be used as spawn point, multiple coords will be used as spawn points and the vehicle will spawn at a random one.
---@field dropPoint? vector3 where a vehicle can be stored, Defaults to spawn or coords

---@class GarageConfig
---@field type? GarageType -- Optional special type of garage. Currently only used to mark IMPOUND garages.
---@field garageVehicleType GarageVehicleType -- Vehicle type
---@field groups? string | string[] | table<string, number> job/gangs that can access the garage
---@field shared? boolean defaults to false. Shared garages give all players with access to the garage access to all vehicles in it. If shared is off, the garage will only give access to player's vehicles which they own.
---@field states? GarageVehicleState | GarageVehicleState[] if set, only vehicles in the given states will be retrievable from the garage. Defaults to GARAGED.
---@field skipGarageCheck? boolean if true, returns vehicles for retrieval regardless of if that vehicle's garage matches this garage's name
---@field canAccess? fun(source: number): boolean checks access as an additional guard clause. Other filter fields still need to pass in addition to this function.
---@field accessPoints AccessPoint[]

---@class GarageErrorResult
---@field code string
---@field message string

---@class GaragePlayerVehicle
---@field id number
---@field citizenid? string
---@field modelName string
---@field garage string
---@field state GarageVehicleState
---@field impoundPrice integer
---@field props table ox_lib properties table

---@class GaragePlayerVehiclesFilters
---@field citizenid? string
---@field states? GarageVehicleState|GarageVehicleState[]
---@field garage? string

---@enum GarageVehicleState
GarageVehicleState = {
    OUT = 0,
    GARAGED = 1,
    IMPOUNDED = 2
}

---@enum GarageVehicleType
GarageVehicleType = {
    CAR = 'car',
    AIR = 'air',
    SEA = 'sea',
    ALL = 'all',
}

---@enum GarageType
GarageType = {
    IMPOUND = 'impound',
}
