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
    
    /// City Ressources
    var ressources: Ressources
    
    /**
     initializer
     
     - parameter map: CityMap
     - parameter budget: city budget
     - parameter population: city population
    */
    init(map: CityMap, budget: Budget, ressources: Ressources, population: Int) {
        self.map = map
        self.population = population
        self.budget = budget
        self.ressources = ressources
    }
    
    /**
     convenience initializer
     
     - parameter map: CityMap
     - parameter startingBudget: starting budget
    */
    convenience init(map: CityMap, startingBudget: Int) {
        let budget = Budget(amount: startingBudget, runningCost: 0)
        let ressources = Ressources(electricityDemand: 0, electricitySupply: 0)
        
        self.init(map: map, budget: budget, ressources: ressources, population: 0)
    }
}