//
//  Street.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 17.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

#if os(iOS)
    @testable import CitySimCoreiOS
#endif

#if os(OSX)
    @testable import CitySimCoreMacOS
#endif

struct StreetPloppTestDouble: RessourceCarrying, Ploppable, MapStatistical, Budgetable {
    let origin: (Int, Int)
    let height: Int
    let width: Int
    var name = "Street"
    let description = "Street"
    let cost: Int? = 20
    let runningCost: Int? = nil
    let type: TileType = .Ploppable(.Street)
    let statistics: MapStatisticContainer = MapStatisticContainer(mapStatistics: .Noise(radius: 0, value: 1))
    
    init(origin: (Int, Int), height: Int, width: Int) {
        self.origin = origin
        
        assert(!(height > 1 && width > 1))
        
        self.height = height
        self.width = width
    }
    
}
