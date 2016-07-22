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
public struct ElectricityActor: Acting, EventSubscribing {
    
    typealias StageType = City
    
    /// actor stage
    /// simulation's main data container
    weak var stage: ActorStageable?
    
    /**
     initializer
     
     - parameter stage: City object work work with
     */
    init(stage: City) {
        self.stage = stage
        stage.map.subscribe(subscriber: self, to: .AddTile)
        stage.map.subscribe(subscriber: self, to: .RemoveTile)
    }

    /**
     Eventhandler for CityMapEvents
     
     - parameter event: the event type
     - parameter payload: the event data
     */
    public func recieveEvent(event event: EventNaming, payload: Any) throws {
        guard let stage = stage as? StageType, let event = event as? CityMapEvent else {
            return
        }
        
        /// a tile may be a consumer and a producer at the same time
        
        /// consumer is added or removed
        if let consumer = payload as? RessourceConsuming {
            update(consumer: consumer, event: event)
        }
        
        /// producer is added or removed
        if let producer = payload as? RessourceProducing {
            update(producer: producer, event: event)
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
        guard let stage = stage as? StageType where stage.ressources.electricityNeedsRecalculation else {
            return
        }
        
        updateConsumers()
    }
    
    private func update(consumer consumer: RessourceConsuming, event: CityMapEvent) {
        guard let stage = stage as? StageType,
              let ressource = consumer.ressources.get(content: .Electricity(nil)),
              let value = ressource.value() else {
            return
        }
        
        if case .AddTile = event {
            /// if the new demand is bigger than the current supply,
            /// recalculation is needed
            /// otherwise, all consumers will be supplied with
            /// electricity, after adding this new one
            stage.ressources.electricityDemand += value
            
            guard stage.ressources.electricityDemand > stage.ressources.electricitySupply else {
                return
            }
            
            stage.ressources.electricityNeedsRecalculation = true
            
            /// newly added tile needs to get status .NotPowered if electricity demand is higher than supply
            var updatedConsumer = consumer
            updatedConsumer.conditions.add(content: .NotPowered)
            
            guard let tile = updatedConsumer as? TileLayer.ValueType else {
                return
            }
            
            do {
                try stage.map.tileLayer.add(tile: tile)
            } catch {
                return
            }
        }
        
        if case .RemoveTile = event {
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
    
    private func update(producer producer: RessourceProducing, event: CityMapEvent) {
        guard let stage = stage as? StageType,
              case .Electricity(let ressourceValue) = producer.ressource,
              let value = ressourceValue else {
            return
        }
        
        if case .AddTile = event {
            /// if the previous supply is smaller than the current demand,
            /// recalculation is needed
            /// otherwise, all consumers are already supplied with electricity
            /// and will still be after adding a new producer
            if stage.ressources.electricitySupply < stage.ressources.electricityDemand {
                stage.ressources.electricityNeedsRecalculation = true
            }
            stage.ressources.electricitySupply += value
        }
        
        if case .RemoveTile = event {
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
    
    /**
     updates electricity consumers based on current electricity supply and demand
     */
    private func updateConsumers() {
        /*defer {
            /// reset recalculation flag
            stage?.ressources.electricityNeedsRecalculation = false
        }*/
    }

}
