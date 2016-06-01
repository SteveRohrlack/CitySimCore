//
//  Street.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 17.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

@testable import CitySimCoreiOS

struct StreetPloppTestDouble: Ploppable, MapStatistical {
    let origin: (Int, Int)
    let height: Int
    let width: Int
    var name = "Street"
    let description = "Street"
    let cost = 20
    let runningCost = 0
    let type: TileType = .Ploppable(.Street)
    let statistics: MapStatisticContainer = MapStatisticContainer(mapStatistics: .Noise(radius: 0, value: 1))
    
    init(origin: (Int, Int), height: Int, width: Int) {
        self.origin = origin
        
        assert(!(height > 1 && width > 1))
        
        self.height = height
        self.width = width
    }
    
}
