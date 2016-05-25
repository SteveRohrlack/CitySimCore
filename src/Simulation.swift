//
//  Simulation.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 23.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/**
 this is the main simulation object
 
 it is used to:
 
 - advance the simulation
 - hold the CityMap
 - hold all active Actors
*/
struct Simulation {
    
    var city: City
    var ticks = 0
    var actors: [Acting] = []
    
    /// advances the simulation by calling every active Actor
    mutating func advance() {
        for (index, _) in actors.enumerate() {
            actors[index].act()
        }
    }
    
}
