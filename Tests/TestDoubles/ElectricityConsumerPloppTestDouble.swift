//
//  ElectricityConsumerTestDouble.swift
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

struct ElectricityConsumerPloppTestDouble: Ploppable, MapStatistical, PlaceNearStreet, RessourceConsuming, Budgetable {
    let origin: (Int, Int)
    let height: Int = 2
    let width: Int = 2
    var name = "Small Park"
    let description = "just a small park"
    let cost: Int? = 100
    let runningCost: Int? = 5
    let type: TileType = .Ploppable(.ParkSmall)
    let statistics: MapStatisticContainer = MapStatisticContainer(mapStatistics: .Landvalue(radius: 3, value: 4))
    var conditions: ConditionContainer = ConditionContainer()
    let ressources: [RessourceType]
    
    init(origin: (Int, Int), consumesAmount amount: Int) {
        self.origin = origin
        self.ressources = [.Electricity(amount)]
    }
    
}
