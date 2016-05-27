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
    
    /// simulation's main data container
    var city: City
    
    /// number of "ticks" the simulation is already running
    var ticks = 0
    
    /// list of actors
    var actors: [Acting] = []
    
    /// advances the simulation by calling every actor
    mutating func advance() {
        for (index, _) in actors.enumerate() {
            actors[index].act()
        }
        
        ticks += 1
    }
    
}
