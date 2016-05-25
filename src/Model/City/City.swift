//
//  City.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 24.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/// the simulation's main data container
class City {
    
    /// CityMap, regards all layers of the map
    var map: CityMap
    
    /// current population count
    var population: Int
    
    /// City budget
    var budget: Budget
    
    /**
     constructor
     
     - parameter map: CityMap
     - parameter budget: city budget
     - parameter population: city population
    */
    init(map: CityMap, budget: Budget, population: Int) {
        self.map = map
        self.population = population
        self.budget = budget
    }
}