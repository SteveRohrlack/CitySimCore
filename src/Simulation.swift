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
public struct Simulation {
    
    /// simulation's main data container
    public private(set) var city: City
    
    /// number of "ticks" the simulation is already running
    public private(set) var ticks: Int
    
    /// list of actors
    var actors: [Acting]
    
    /**
     initializer
     
     - parameter city: city object
     - parameter ticks: number of ticks
     - parameter actors: array of actors
     */
    init(city: City, ticks: Int, actors: [Acting]) {
        self.city = city
        self.ticks = ticks
        self.actors = actors
    }
    
    /**
     convenience initializer
     
     - parameter city: city object
    */
    init(city: City) {
        self.init(city: city, ticks: 0, actors: [])
    }
    
    /// advances the simulation by calling every actor
    public mutating func advance() {
        for (index, _) in actors.enumerate() {
            actors[index].act()
        }
        
        ticks += 1
    }

}
