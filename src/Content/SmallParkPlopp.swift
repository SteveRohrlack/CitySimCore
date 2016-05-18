//
//  SmallPark.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 17.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

struct SmallParkPlopp: TileablePloppable, MapStatistical {
    let origin: (Int, Int)
    let height: Int = 2
    let width: Int = 3
    var name = "Small Park"
    let description = "just a small park"
    let cost = 100
    let type: TileType = .Ploppable(.ParkSmall)
    let statistics: [MapStatistic] = [.Landvalue(radius: 3, value: 4)]
    
    init(origin: (Int, Int)) {
        self.origin = origin
    }
}