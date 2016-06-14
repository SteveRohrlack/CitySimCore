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
public class ElectricityActor: Acting, EventSubscribing {
    
    /// actor stage
    /// simulation's main data container
    var stage: City
    
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
    public func recieveEvent(event event: EventNaming, payload: Any) throws {
        guard let event = event as? CityMapEvent else {
            return
        }
        
        /// update consumers if consumer is added or removed
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
                guard let value = ressource.value() else {
                    continue
                }
                
                if case .AddTile = event {
                    stage.ressources.electricityDemand += value
                }
                        
                if case .RemoveTile = event {
                    stage.ressources.electricityDemand -= value
                }
            }
            
            updateConsumers()
        }
        
        /// update consumers if producer is added or removed
        if let producer = payload as? RessourceProducing {
            guard case .Electricity(let ressourceValue) = producer.ressource, let value = ressourceValue else {
                return
            }
            
            if case .AddTile = event {
                stage.ressources.electricitySupply += value
            }
                
            if case .RemoveTile = event {
                stage.ressources.electricitySupply -= value
            }
            
            updateConsumers()
        }
        
        /// update consumers if RessourceCarrier is added or removed
        if let _ = payload as? RessourceCarrying {
            updateConsumers()
        }
    }
    
    /**
     updates electricity consumers based on current electricity supply and demand
    */
    private func updateConsumers() {
        /// no consumption
        guard stage.ressources.electricityDemand > 0 else {
            return
        }

        /// no production, every conditionable consumer should get condition "not powered"
        guard stage.ressources.electricitySupply > 0 else {
            let allConditionableElectricityConsumers = stage.map.tileLayer.values.filter { (tile) in
                guard let tile = tile as? RessourceConsuming where tile is Conditionable && tile.consumes(ressource: .Electricity(nil)) else {
                    return false
                }
                
                return true
            }
            
            /// update tile status to "not powered"
            allConditionableElectricityConsumers.forEach { (tile) in
                guard let tile = tile else {
                    return
                }
                
                var conditionableTile = tile as! Conditionable  // tailor:disable
                conditionableTile.conditions.add(content: .NotPowered)
                stage.map.tileLayer[tile.origin] = conditionableTile as? TileLayer.ValueType
            }
            
            return
        }

        /// retrieve all electricity producers
        let allElectricityProducers = stage.map.tileLayer.values.filter { (tile) in
            guard let producer = tile as? RessourceProducing where producer.ressource >= .Electricity(nil) else {
                return true
            }
            
            return false
        }
        
        /// track electricity flow on ressource carriers and
        /// reproduce consumption for each adjecant consumer
        
    }
    
}
