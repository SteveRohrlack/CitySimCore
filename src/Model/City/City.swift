//
//  City.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 24.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/// the simulation's main data container
public class City: EventEmitting, ActorStageable {
    
    typealias EventNameType = CityEvent
    
    /// Container holding event subscribers
    var eventSubscribers: [EventNameType: [EventSubscribing]] = [:]
    
    /// CityMap, regards all layers of the map
    public var map: CityMap
    
    /// current population count
    public var population: Int {
        didSet {
            emitPopulationThresholdEvents(oldValue: oldValue)
        }
    }
    
    /// list of population thresholds that trigger events
    private var populationThresholds: [Int] = []
    
    /// City budget
    public var budget: Budget
    
    /// City Ressources
    public var ressources: Ressources
    
    /**
     initializer
     
     - parameter map: CityMap
     - parameter budget: city budget
     - parameter population: city population
     - parameter populationThresholds: population thresholds that trigger events
    */
    init(map: CityMap, budget: Budget, ressources: Ressources, population: Int, populationThresholds: [Int]) {
        self.map = map
        self.budget = budget
        self.ressources = ressources
        self.population = population
        self.populationThresholds = populationThresholds
    }
    
    /**
     convenience initializer
     
     - parameter map: CityMap
     - parameter startingBudget: starting budget
     - parameter populationThresholds: population thresholds that trigger events
    */
    convenience init(map: CityMap, startingBudget: Int) {
        let budget = Budget(amount: startingBudget, runningCost: 0)
        let ressources = Ressources(electricityDemand: 0, electricitySupply: 0, electricityNeedsRecalculation: false)
        
        self.init(map: map, budget: budget, ressources: ressources, population: 0, populationThresholds: [])
    }
    
    /**
     convenience initializer
     
     - parameter map: CityMap
     - parameter startingBudget: starting budget
     */
    convenience init(map: CityMap, startingBudget: Int, populationThresholds: [Int]) {
        let budget = Budget(amount: startingBudget, runningCost: 0)
        let ressources = Ressources(electricityDemand: 0, electricitySupply: 0, electricityNeedsRecalculation: false)
        
        self.init(map: map, budget: budget, ressources: ressources, population: 0, populationThresholds: populationThresholds)
    }
    
    /**
     determines if city population threshold event should be triggered
     
     - parameter oldValue: value before population-value was changed
    */
    private func emitPopulationThresholdEvents(oldValue oldValue: Int) {
        for threshold in populationThresholds {
            if oldValue < threshold && population >= threshold {
                do {
                    try emit(event: .PopulationReachedThreshold, payload: threshold)
                } catch {}
            }
        }
    }

}