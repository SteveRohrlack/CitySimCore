//
//  ElectricityActor.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 30.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation
import GameplayKit

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
        
        /// a tile may be a consumer and a producer at the same time
        
        /// consumer is added or removed
        if let consumer = payload as? RessourceConsuming {
            for ressource in consumer.ressources {
                guard case .Electricity = ressource, let value = ressource.value() else {
                    continue
                }
                
                switch event {
                case .AddTile:
                    /// if the new demand is bigger than the current supply,
                    /// recalculation is needed
                    /// otherwise, all consumers will be supplied with
                    /// electricity, after adding this new one
                    stage.ressources.electricityDemand += value
                    if stage.ressources.electricityDemand > stage.ressources.electricitySupply {
                       stage.ressources.electricityNeedsRecalculation = true
                    }
                case .RemoveTile:
                    /// if the previous demand is already bigger than the supply,
                    /// recalculation is needed
                    /// otherwise, all consumers have already been supplied with
                    /// electricity, and will still be if a consumer is removed
                    if stage.ressources.electricityDemand > stage.ressources.electricitySupply {
                        stage.ressources.electricityNeedsRecalculation = true
                    }
                    stage.ressources.electricityDemand -= value
                }
            }
        }
        
        /// producer is added or removed
        if let producer = payload as? RessourceProducing {
            guard case .Electricity(let ressourceValue) = producer.ressource, let value = ressourceValue else {
                return
            }
            
            switch event {
            case .AddTile:
                /// if the previous supply is smaller than the current demand,
                /// recalculation is needed
                /// otherwise, all consumers are already supplied with electricity
                /// and will still be after adding a new producer
                if stage.ressources.electricitySupply < stage.ressources.electricityDemand {
                    stage.ressources.electricityNeedsRecalculation = true
                }
                stage.ressources.electricitySupply += value
            case .RemoveTile:
                /// if the new supply is smaller than the current demand,
                /// recalculation is needed
                /// otherwise, all consumers are still being supplied with
                /// electricity, and will still be if the producer is removed
                stage.ressources.electricitySupply -= value
                if stage.ressources.electricitySupply < stage.ressources.electricityDemand {
                    stage.ressources.electricityNeedsRecalculation = true
                }
            }
        }
        
        /// update consumers if RessourceCarrier is added or removed
        if let _ = payload as? RessourceCarrying {
            stage.ressources.electricityNeedsRecalculation = true
        }
    }
    
    /**
     the ElectricityActor updates electricity consumers state
     
     - parameter tick: the current simulation tick
     */
    func act(tick tick: Int) {
        guard stage.ressources.electricityNeedsRecalculation else {
            return
        }
        
        updateConsumers()
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
        
        /// retrieve all electricity producers and consumers
        let allProducers = stage.map.tileLayer.values.filter { (tile) in
            guard let producer = tile as? RessourceProducing where producer.ressource >= .Electricity(nil) else {
                return true
            }
            
            return false
        }
        
        let allConsumers = stage.map.tileLayer.values.filter { (tile) in
            guard let consumer = tile as? RessourceConsuming where consumer.consumes(ressource: .Electricity(nil)) else {
                return true
            }
            
            return false
        }
        
        /// if a consumer is supplied with electricity by one producer,
        /// it doesn't need to be supplied by another one
        var suppliedConsumers: [TileLayer.ValueType?] = []
        
        /// track electricity flow on ressource carriers by temporarily adding
        /// producers and consumers to the graph
        for producer in allProducers {
            guard let producer = producer as? Graphable else {
                continue
            }
            
            let producerNodes = producer.asNodes()
            
            /// temporary inclusion of producer in ressource grid
            stage.map.graph.addNodes(producerNodes)
            
            for consumer in allConsumers {
                guard let consumer = consumer as? Graphable else {
                    continue
                }
                
                let consumerNodes = consumer.asNodes()
                
                /// temporary inclusion of consumer in ressource grid
                stage.map.graph.addNodes(consumerNodes)
                
                /// track electricity flow
                
                
                /// remove consumer from ressource grid
                stage.map.graph.removeNodes(consumerNodes)
            }
            
            /// remove producer from ressource grid
            stage.map.graph.removeNodes(producerNodes)
        }
        
        /// reset recalculation flag
        stage.ressources.electricityNeedsRecalculation = false
    }

}
