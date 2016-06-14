//
//  SmallPark.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 17.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

struct SmallParkPlopp: Ploppable, Budgetable, MapStatistical, Conditionable, PlaceNearStreet, Budgetable, RessourceConsuming {
    let origin: (Int, Int)
    let height: Int = 2
    let width: Int = 3
    var name = "Small Park"
    let description = "just a small park"
    let cost: Int? = 100
    let runningCost: Int? = 5
    let type: TileType = .Ploppable(.ParkSmall)
    let statistics: MapStatisticContainer = MapStatisticContainer()
    var conditions: ConditionContainer = ConditionContainer()
    let ressources: [RessourceType] = [.Electricity(100), .Water(10)]
    
    init(origin: (Int, Int)) {
        self.origin = origin
    }
}