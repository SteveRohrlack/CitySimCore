//
//  ElectricityProducerTestDouble.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 15.06.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

#if os(iOS)
    @testable import CitySimCoreiOS
#endif

#if os(OSX)
    @testable import CitySimCoreMacOS
#endif

struct ElectricityProducerPloppTestDouble: Ploppable, PlaceNearStreet, RessourceProducing {
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
    let ressource: RessourceType
    
    init(origin: (Int, Int), producesAmount amount: Int) {
        self.origin = origin
        self.ressource = .Electricity(amount)
    }
    
    init(origin: (Int, Int)) {
        self.origin = origin
        self.ressource = .Electricity(100)
    }

}
