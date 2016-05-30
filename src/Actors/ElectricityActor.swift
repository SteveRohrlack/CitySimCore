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
     constructor
     
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
        guard let _ = event as? CityMapEvents else {
            return
        }
        
        if let consumer = payload as? RessourceConsuming {
            /// add city.ressources consumptions
            recalculateElectricityConsumption()
        }
        
        if let producer = payload as? RessourceProducing {
            /// add city.ressources productions
            recalculateElectricityConsumption()
        }
        
        /// recalculate if streetplopp is added
    }
    
    /// calculates the current consumption of electricity
    internal func recalculateElectricityConsumption() {
        
    }
    
    internal func act() {
        
    }
    
}
