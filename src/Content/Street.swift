//
//  Street.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 17.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

struct Street: Buildable {
    let name = "Street"
    let description = "Street"
    let cost = 20
    let type: PloppableType = .Street
    let statistics: [MapStatistic] = [.Noise(radius: 0, value: 1)]
}