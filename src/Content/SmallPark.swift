//
//  SmallPark.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 17.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

struct SmallPark: Buildable {
    let name = "Small Park"
    let description = "just a small park"
    let cost = 100
    let height = 2
    let width = 3
    let type: PloppableType = .ParkSmall
    let statistics: [MapStatistic] = [.Landvalue(radius: 3, value: 4)]
}