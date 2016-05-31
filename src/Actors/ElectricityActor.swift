//
//  ElectricityActor.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 30.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/**
 The ElectricityActor
*/
class ElectricityActor: Acting, EventSubscribing {
    
    /// actor stage
    /// simulation's main data container
    internal var stage: City
    
    /**
     initializer
     
     - parameter stage: City object work work with
     */
    init(stage: City) {
        self.stage = stage
        self.stage.map.subscribe(subscriber: self, to: .AddTile)
        self.stage.map.subscribe(subscriber: self, to: .RemoveTile)
    }
    
    /**
     Eventhandler for CityMapEvents
     
     - parameter event: the event type
     - parameter payload: the event data
     */
    internal func recieveEvent(event event: EventNaming, payload: Any) throws {
        guard let event = event as? CityMapEvents else {
            return
        }
        
        /// consumers
        if let consumer = payload as? RessourceConsuming {
            let electricityRessources = consumer.ressources.filter { (ressource) in
                guard case .Electricity = ressource else {
                    return false
                }
                
                return true
            }
            
            guard electricityRessources.count > 0 else {
                return
            }
            
            for ressource in electricityRessources {
                if case .AddTile = event {
                    stage.ressources.electricityDemand += ressource.value()
                }
                        
                if case .RemoveTile = event {
                    stage.ressources.electricityDemand -= ressource.value()
                }
            }
        }
        
        /// producers
        if let producer = payload as? RessourceProducing {
            guard case .Electricity(let value) = producer.ressource else {
                return
            }
            
            if case .AddTile = event {
                stage.ressources.electricitySupply += value
            }
                
            if case .RemoveTile = event {
                stage.ressources.electricitySupply -= value
            }
                
            recalculateElectricityConsumption()
        }
        
        /// recalculate if streetplopp is added
    }
    
    /// calculates the current consumption of electricity
    internal func recalculateElectricityConsumption() {
        
    }
    
    /// the ElectricityActor doesn't act, it just handles events
    internal func act() {
        
    }
    
}
