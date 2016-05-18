//
//  Street.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 17.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

struct StreetPlopp: Ploppable, MapStatistical {
    let origin: (Int, Int)
    let height: Int = 1
    let width: Int = 1
    var name = "Street"
    let description = "Street"
    let cost = 20
    let type: TileType = .Ploppable(.Street)
    let statistics: [MapStatistic] = [.Noise(radius: 0, value: 1)]
    
    init(origin: (Int, Int)) {
        self.origin = origin
    }
}