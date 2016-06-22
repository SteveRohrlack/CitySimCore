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
    
    /// shortcut to get all producers
    var producers: [TileLayer.ValueType] {
        return stage.map.tileLayer.filter { (tile) in
            guard let producer = tile as? RessourceProducing where producer.ressource >= .Electricity(nil) else {
                return false
            }
            
            return true
        }
    }
    
    /// shortcut to get all consumers
    var consumers: [TileLayer.ValueType] {
        return stage.map.tileLayer.filter { (tile) in
            guard let consumer = tile as? RessourceConsuming where consumer.consumes(ressource: .Electricity(nil)) else {
                return false
            }
            
            return true
        }
    }
    
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
            guard let ressource = consumer.ressources.get(content: .Electricity(nil)), value = ressource.value() else {
                return
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
                    
                    /// newly added tile needs to get status .NotPowered if electricity demand is higher than supply
                    var updatedConsumer = consumer
                    updatedConsumer.conditions.add(content: .NotPowered)
                    
                    guard let updatedTile = updatedConsumer as? TileLayer.ValueType else {
                        return
                    }
                    
                    do {
                        try self.stage.map.tileLayer.add(tile: updatedTile)
                    } catch {
                        return
                    }
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
        defer {
            /// reset recalculation flag
            stage.ressources.electricityNeedsRecalculation = false
        }
        
        /// no consumption
        guard stage.ressources.electricityDemand > 0 else {
            return
        }
        
        /// no production, every consumer should get condition "not powered"
        guard stage.ressources.electricitySupply > 0 else {
            /// update tile status to "not powered"
            changeCondition(for: consumers, to: .NotPowered)
            return
        }

        let allProducers = producers
        var calculateForConsumers = consumers
        
        /// track electricity flow on ressource carriers by temporarily adding
        /// producers and consumers to the graph
        for producer in allProducers {
            /// temporary inclusion of producer in ressource grid
            stage.map.trafficLayer.add(location: producer as Locateable)

            let startNode = stage.map.trafficLayer.nodeAtGridPosition(location: producer as Locateable)!
            
            /// aggregate distance from producer to consumers
            var distances: [Distance]? = []
            
            for consumer in calculateForConsumers {
                /// temporary inclusion of consumer in ressource grid
                stage.map.trafficLayer.add(location: consumer as Locateable)
                
                /// track electricity flow
                let endNode = stage.map.trafficLayer.nodeAtGridPosition(location: consumer as Locateable)!
                
                let path = stage.map.trafficLayer.findPathFromNode(startNode, toNode: endNode)
                
                if path.count > 0 {
                    distances!.append(Distance(from: producer, to: consumer, distance: path.count))
                }
                
                /// remove consumer from ressource grid
                stage.map.trafficLayer.remove(location: consumer as Locateable)
            }

            /// remove producer from ressource grid
            stage.map.trafficLayer.remove(location: producer as Locateable)
            
            /// sort paths
            distances!.sortInPlace { $0.distance < $1.distance }
            
            /// provide consumers with electricity based on their distance to the producer
            guard let ressourceProducer = producer as? RessourceProducing, let producedRessourceValue = ressourceProducer.ressource.value() else {
                continue
            }
            
            var ressourceAmount = producedRessourceValue
            for distance in distances! {
                guard ressourceAmount > 0 else {
                    break
                }
                
                guard let ressourceConsumer = distance.to as? RessourceConsuming, let ressource = ressourceConsumer.ressources.get(content: .Electricity(nil)), let value = ressource.value() else {
                    continue
                }
                
                guard ressourceAmount - value > 0 else {
                    break
                }
                
                /// this consumer does not have to be supplied by another producer
                var updatedConsumer = ressourceConsumer
                updatedConsumer.conditions.remove(content: .NotPowered)

                guard let updatedTile = updatedConsumer as? TileLayer.ValueType else {
                    continue
                }
                
                do {
                    try self.stage.map.tileLayer.add(tile: updatedTile)
                } catch {
                    continue
                }

                ressourceAmount -= value

                calculateForConsumers = calculateForConsumers.filter { !($0 == distance.to) }
            }
            
            distances = nil
        }
    }
    
    /**
     changes the condition of all given tiles
     
     - parameter for: list of consumers
     - parameter to: condition
    */
    private func changeCondition(for tiles: [TileLayer.ValueType], to condition: Condition) {
        for tile in tiles {
            guard let conditionableTile = tile as? Conditionable else {
                continue
            }
            
            var conditionable = conditionableTile
            conditionable.conditions.add(content: condition)
            
            guard let updatedTile = conditionable as? TileLayer.ValueType else {
                continue
            }
            
            do {
                try self.stage.map.tileLayer.add(tile: updatedTile)
            } catch {
                continue
            }
        }
    }

}
