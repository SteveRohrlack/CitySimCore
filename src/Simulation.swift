//
//  Simulation.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 23.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

struct Simulation {
    
    var map: CityMap
    var ticks = 0
    var actors: [Acting] = []
    
    mutating func advance() {
        for (index, _) in actors.enumerate() {
            actors[index].act(on: map)
        }
    }
    
}