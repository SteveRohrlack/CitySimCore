//
//  Powerplant.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 15.06.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

struct PowerplantPlopp: Ploppable, Conditionable, MapStatistical, Budgetable, PlaceNearStreet, RessourceProducing {
    let origin: (Int, Int)
    let height: Int = 4
    let width: Int = 4
    var name = "Powerplant"
    let description = "just a small powerplant"
    let cost: Int? = 1000
    let runningCost: Int? = 200
    let type: TileType = .Ploppable(.Powerplant)
    let statistics: MapStatisticContainer = MapStatisticContainer(mapStatistics: .Noise(radius: 3, value: 4))
    var conditions: ConditionContainer = ConditionContainer()
    let ressource: RessourceType = .Electricity(100)
    
    init(origin: (Int, Int)) {
        self.origin = origin
    }

}