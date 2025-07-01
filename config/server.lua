return {
    autoRespawn = false, -- True == auto respawn cars that are outside into your garage on script restart, false == does not put them into your garage and players have to go to the impound
    warpInVehicle = true, -- If false, player will no longer warp into vehicle upon taking the vehicle out.
    doorsLocked = true, -- If true, the doors will be locked upon taking the vehicle out.
    distanceCheck = 5.0, -- The distance that needs to bee clear to let the vehicle spawn, this prevents vehicles stacking on top of each other
    ---calculates the automatic impound fee.
    ---@param vehicleId integer
    ---@param modelName string
    ---@return integer fee
    calculateImpoundFee = function(vehicleId, modelName)
        local vehCost = VEHICLES[modelName].price
        return qbx.math.round(vehCost * 0.02) or 0
    end,

    ---@type table<string, GarageConfig>
    garages = {
        -- Public Garages
        ["Legion Square"] = { -- If you change the name of this garage from Legion Square, you must change the default value of `garage_id` to the same name in the SQL table `players_vehicles`
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(215.66, -809.93, 30.73),
                    spawn = {vector4(222.16, -804.25, 30.58, 250.0), -- Make it work with multiple spawn points
                            vector4(223.46, -799.04, 30.58, 250.0),
                            vector4(226.3, -791.58, 30.58, 250.0),
                            vector4(215.43, -775.99, 30.43, 248.98),
                            vector4(232.69, -773.72, 30.32, 249.76)
                    }, --  you can add multiple spawn locations into a table
                }
            },
        },
        ["Islington South"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(273.0, -343.85, 44.91),
                    spawn = { vector4(266.84, -328.77, 44.5, 249.42), -- Make it work with multiple spawn points
                            vector4(269.29, -322.26, 44.5, 249.45),
                            vector4(287.66, -329.12, 44.5, 249.52),
                            vector4(283.91, -338.77, 44.5, 249.58),
                            vector4(294.68, -346.56, 44.5, 69.93), },
                }
            },
        },
        ["Grove Street"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(14.66, -1728.52, 29.3),
                    spawn = vector4(23.93, -1722.9, 29.3, 310.58),
                }
            },
        },
        ["Mirror Park"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(1034.69, -766.03, 58.0),
                    spawn = {vector4(1017.16, -760.3, 57.55, 222.93), -- Make it work with multiple spawn points
                            vector4(1027.52, -785.35, 57.45, 310.28),
                            vector4(1047.0, -785.62, 57.57, 91.26)},
                }
            },
        },
        ["Beach"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(-1248.69, -1425.71, 4.32),
                    spawn = vector4(-1244.27, -1422.08, 4.32, 37.12),
                }
            },
        },
        ["Great Ocean Highway"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(-2961.58, 375.93, 15.02),
                    spawn = vector4(-2964.96, 372.07, 14.78, 86.07),
                }
            },
        },
        ["Sandy South"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(217.33, 2605.65, 46.04),
                    spawn = vector4(216.94, 2608.44, 46.33, 14.07),
                }
            },
        },
        ["Sandy North"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(1878.44, 3760.1, 32.94),
                    spawn = vector4(1880.14, 3757.73, 32.93, 215.54),
                }
            },
        },
        ["North Vinewood Blvd"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(364.39, 297.84, 103.49),
                    spawn = {vector4(386.95, 291.72, 102.63, 165.04), -- Make it work with multiple spawn points
                            vector4(392.69, 280.48, 102.56, 71.03),
                            vector4(371.48, 266.74, 102.6, 340.53)},
                }
            },
        },
        ["Grapeseed"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(1698.05, 4792.72, 41.92),
                    spawn = {vector4(1691.42, 4788.03, 41.5, 89.22), -- Make it work with multiple spawn points
                            vector4(1691.61, 4774.13, 41.5, 91.71)},
                }
            },
        },
        ["Textile City"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(412.74, -634.35, 28.5),
                    spawn = { vector4(408.8, -638.68, 28.08, 270.0), -- Make it work with multiple spawn points
                            vector4(393.08, -638.73, 28.08, 270.81),
                            vector4(393.21, -649.69, 28.08, 270.43),
                            vector4(392.48, -657.72, 28.08, 270.83),
                            vector4(415.9, -649.35, 28.08, 270.51)},
                }
            },
        },
        ["Pillbox Hill"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(-332.01, -781.39, 33.96),
                    spawn = {vector4(-320.15, -752.3, 33.54, 159.86), -- Make it work with multiple spawn points
                            vector4(-331.77, -750.56, 33.54, 181.7),
                            vector4(-341.29, -756.81, 33.54, 91.4),
                            vector4(-357.49, -764.41, 33.54, 269.31),
                            vector4(-307.79, -756.62, 33.54, 161.04),},
                }
            },
        },
        ["West Vinewood"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(-515.93, 53.0, 52.58),
                    spawn = {vector4(-537.01, 40.77, 52.16, 265.99), -- Make it work with multiple spawn points
                            vector4(-509.52, 65.48, 52.16, 85.36),
                            vector4(-510.96, 55.17, 52.16, 84.34),
                            vector4(-519.69, 66.28, 52.16, 84.99),
                            vector4(-504.47, 54.48, 56.07, 265.69)},
                }
            },
        },
        ["West Vinewood 2"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(-570.24, 311.83, 84.49),
                    spawn = {vector4(-580.68, 314.45, 84.37, 354.67), -- Make it work with multiple spawn points
                            vector4(-588.58, 335.45, 84.67, 175.84),
                            vector4(-601.55, 345.46, 84.69, 175.98) },
                }
            },
        },
        ["Vinewood Hills"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(886.2, -1.13, 78.76),
                    spawn = {vector4(858.37, -28.97, 78.34, 237.92), -- Make it work with multiple spawn points
                            vector4(865.02, -45.35, 78.34, 57.82),
                            vector4(890.62, -45.15, 78.34, 57.29) },
                }
            },
        },
        ["Vinewood Hills 2"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(664.45, 630.94, 128.91),
                    spawn = {vector4(638.47, 606.27, 128.49, 250.49), -- Make it work with multiple spawn points
                            vector4(654.98, 606.79, 128.49, 71.33),
                            vector4(636.39, 625.62, 128.49, 70.06)},
                }
            },
        },
        ["Vinewood Hills 3"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(-77.07, 907.36, 235.81),
                    spawn = {vector4(-66.23, 892.11, 235.13, 115.63), -- Make it work with multiple spawn points
                            vector4(-71.02, 903.26, 235.19, 114.49)},
                }
            },
        },
        ["Harmony"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(599.73, 2726.74, 41.91),
                    spawn = { vector4(624.26, 2724.0, 41.4, 5.26), vector4(583.25, 2736.76, 41.58, 184.15), vector4(581.21, 2720.36, 41.64, 4.71) },
                }
            },
        },
        ["Banham Canyon"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(-3048.89, 611.0, 7.18),
                    spawn = { vector4(-3056.03, 608.34, 6.79, 291.97), vector4(-3053.88, 602.67, 6.87, 289.86), vector4(-3051.78, 596.95, 7.02, 289.15) },
                }
            },
        },
        ["Grand Senora"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(1984.54, 3065.77, 47.01),
                    spawn = { vector4(2012.04, 3055.3, 46.62, 58.94), vector4(2016.86, 3062.81, 46.62, 60.09), vector4(1999.63, 3081.81, 46.65, 148.07) },
                }
            },
        },
        ["Sandy Shores MC"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(1836.58, 3668.21, 33.68),
                    spawn = { vector4(1853.67, 3676.2, 33.33, 210.23), vector4(1831.35, 3663.51, 33.44, 210.09), vector4(1825.11, 3659.53, 33.58, 209.13) },
                }
            },
        },
        ["San Chianski"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(2761.43, 3452.49, 55.84),
                    spawn = { vector4(2775.86, 3436.56, 55.39, 67.43), vector4(2791.24, 3474.5, 54.85, 68.56), vector4(2769.44, 3473.51, 55.08, 67.23) },
                }
            },
        },
        ["La Puerta"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(-1082.51, -1261.67, 5.61),
                    spawn = { vector4(-1075.61, -1267.34, 5.48, 299.93), vector4(-1080.98, -1258.0, 5.13, 300.38), vector4(-1074.83, -1240.87, 4.85, 120.24) },
                }
            },
        },
        ["Paleto Bay"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(137.66, 6612.97, 31.83),
                    spawn = { vector4(151.05, 6607.28, 31.45, 358.41), vector4(145.84, 6613.57, 31.39, 359.11), vector4(155.75, 6592.76, 31.42, 179.37) },
                }
            },
        },
        ["Paleto Bay 2"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(-274.94, 6126.03, 31.48),
                    spawn = { vector4(-282.03, 6142.62, 31.08, 135.25), vector4(-276.61, 6137.28, 31.08, 135.7), vector4(-303.97, 6129.09, 31.08, 225.36) },
                }
            },
        },
        ["Rancho"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(384.21, -1612.76, 29.29),
                    spawn = { vector4(395.51, -1626.53, 28.87, 49.3), vector4(388.55, -1612.64, 28.87, 230.57) },
                }
            },
        },
        ["Rancho 2"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(443.0, -1969.08, 24.4),
                    spawn = { vector4(453.99, -1965.92, 22.55, 180.38), vector4(449.5, -1960.62, 22.55, 182.45) },
                }
            },
        },
        ["Del Perro"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(-1523.96, -451.46, 35.6),
                    spawn = { vector4(-1522.3, -418.57, 35.02, 230.52), vector4(-1526.95, -423.81, 35.02, 230.73) },
                }
            },
        },
        ["Davis"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(-71.77, -1821.7, 26.94),
                    spawn = { vector4(-60.26, -1843.13, 26.16, 319.89), vector4(-52.36, -1849.82, 25.85, 320.93) },
                }
            },
        },
        ["Mount Chiliad"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(1721.4, 6410.46, 34.01),
                    spawn = { vector4(1729.74, 6405.79, 34.04, 152.75), vector4(1717.45, 6416.34, 33.02, 243.98) },
                }
            },
        },
        ["Zancudo River"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(-1130.62, 2675.25, 18.18),
                    spawn = { vector4(-1159.62, 2673.95, 17.67, 222.74), vector4(-1154.93, 2678.09, 17.67, 220.94) },
                }
            },
        },
        ["Tataviam Mountains"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(2588.15, 426.63, 108.55),
                    spawn = { vector4(2576.07, 428.77, 108.03, 180.28), vector4(2583.07, 428.63, 108.03, 179.74) },
                }
            },
        },
        ["LS Airport"] = {
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Public Parking',
                        sprite = 357,
                        color = 3,
                    },
                    coords = vector3(-949.49, -2582.63, 13.83),
                    spawn = { vector4(-957.98, -2604.35, 13.42, 60.79), -- Make it work with multiple spawn points
                            vector4(-957.04, -2583.48, 13.41, 240.27) },
                }
            },
        },
        ['Airport Hangar'] = {
            garageVehicleType = GarageVehicleType.AIR,
            accessPoints = {
                {
                    blip = {
                        name = 'Hangar',
                        sprite = 360,
                        color = 3,
                    },
                    coords = vec4(-1025.34, -3017.0, 13.95, 331.99),
                    spawn = vec4(-979.2, -2995.51, 13.95, 52.19),
                }
            },
        },
        ['Higgins Helitours'] = {
            garageVehicleType = GarageVehicleType.AIR,
            accessPoints = {
                {
                    blip = {
                        name = 'Hangar',
                        sprite = 360,
                        color = 3,
                    },
                    coords = vec4(-722.12, -1472.74, 5.0, 140.0),
                    spawn = vec4(-724.83, -1443.89, 5.0, 140.0),
                }
            },
        },
        ['Sandy Shores Hangar'] = {
            garageVehicleType = GarageVehicleType.AIR,
            accessPoints = {
                {
                    blip = {
                        name = 'Hangar',
                        sprite = 360,
                        color = 3,
                    },
                    coords = vec4(1757.74, 3296.13, 41.15, 142.6),
                    spawn = vec4(1740.88, 3278.99, 41.09, 189.46),
                }
            },
        },
        ['LSYMC Boathouse'] = {
            garageVehicleType = GarageVehicleType.SEA,
            accessPoints = {
                {
                    blip = {
                        name = 'Boathouse',
                        sprite = 356,
                        color = 3,
                    },
                    coords = vec4(-794.64, -1510.89, 1.6, 201.55),
                    spawn = vec4(-793.58, -1501.4, 0.12, 111.5),
                }
            },
        },
        ['Paleto Boathouse'] = {
            garageVehicleType = GarageVehicleType.SEA,
            accessPoints = {
                {
                    blip = {
                        name = 'Boathouse',
                        sprite = 356,
                        color = 3,
                    },
                    coords = vec4(-277.4, 6637.01, 7.5, 40.51),
                    spawn = vec4(-289.2, 6637.96, 1.01, 45.5),
                }
            },
        },
        ['Millars Boathouse'] = {
            garageVehicleType = GarageVehicleType.SEA,
            accessPoints = {
                {
                    blip = {
                        name = 'Boathouse',
                        sprite = 356,
                        color = 3,
                    },
                    coords = vec4(1299.02, 4216.42, 33.91, 166.8),
                    spawn = vec4(1296.78, 4203.76, 30.12, 169.03),
                }
            },
        },

        -- Job Garages
        ['Police Garage'] = {
            garageVehicleType = GarageVehicleType.CAR,
            groups = 'police',
            accessPoints = {
                {
                    coords = vec4(454.6, -1017.4, 28.4, 0),
                    spawn = vec4(438.4, -1018.3, 27.7, 90.0),
                }
            },
        },

        -- Gang Garages
        ['Ballas'] = {
            garageVehicleType = GarageVehicleType.CAR,
            groups = 'ballas',
            accessPoints = {
                {
                    coords = vec4(98.50, -1954.49, 20.84, 0),
                    spawn = vec4(98.50, -1954.49, 20.75, 335.73),
                }
            },
        },
        ['La Familia'] = {
            garageVehicleType = GarageVehicleType.CAR,
            groups = 'families',
            accessPoints = {
                {
                    coords = vec4(-811.65, 187.49, 72.48, 0),
                    spawn = vec4(-818.43, 184.97, 72.28, 107.85),
                }
            },
        },
        ['Lost MC'] = {
            garageVehicleType = GarageVehicleType.CAR,
            groups = 'lostmc',
            accessPoints = {
                {
                    coords = vec4(957.25, -129.63, 74.39, 0),
                    spawn = vec4(957.25, -129.63, 74.39, 199.21),
                }
            },
        },
        ['Cartel'] = {
            garageVehicleType = GarageVehicleType.CAR,
            groups = 'cartel',
            accessPoints = {
                {
                    coords = vec4(1407.18, 1118.04, 114.84, 0),
                    spawn = vec4(1407.18, 1118.04, 114.84, 88.34),
                }
            },
        },

        -- Impound Lots
        ['Impound Lot'] = {
            type = GarageType.IMPOUND,
            states = {GarageVehicleState.OUT, GarageVehicleState.IMPOUNDED},
            skipGarageCheck = true,
            garageVehicleType = GarageVehicleType.CAR,
            accessPoints = {
                {
                    blip = {
                        name = 'Impound Lot',
                        sprite = 68,
                        color = 3,
                    },
                    coords = vec4(400.45, -1630.87, 29.29, 228.88),
                    spawn = vec4(407.2, -1645.58, 29.31, 228.28),
                }
            },
        },
        ['Air Impound'] = {
            type = GarageType.IMPOUND,
            states = {GarageVehicleState.OUT, GarageVehicleState.IMPOUNDED},
            skipGarageCheck = true,
            garageVehicleType = GarageVehicleType.AIR,
            accessPoints = {
                {
                    blip = {
                        name = 'Air Impound',
                        sprite = 359,
                        color = 3,
                    },
                    coords = vec4(-1244.35, -3391.39, 13.94, 59.26),
                    spawn = vec4(-1269.03, -3376.7, 13.94, 330.32),
                }
            },
        },
        ['LSYMC Impound'] = {
            type = GarageType.IMPOUND,
            states = {GarageVehicleState.OUT, GarageVehicleState.IMPOUNDED},
            skipGarageCheck = true,
            garageVehicleType = GarageVehicleType.SEA,
            accessPoints = {
                {
                    blip = {
                        name = 'LSYMC Impound',
                        sprite = 356,
                        color = 3,
                    },
                    coords = vec4(-772.71, -1431.11, 1.6, 48.03),
                    spawn = vec4(-729.77, -1355.49, 1.19, 142.5),
                }
            },
        },
    },
}
