//
//  City.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 24.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/// the sinulation's main data container
class City {
    
    /// CityMap, regards all layers of the map
    var map: CityMap
    
    /// current population count
    var population: Int
    
    /// current budget
    var budget: Int
    
    init(map: CityMap, population: Int, budget: Int) {
        self.map = map
        self.population = population
        self.budget = budget
    }
}