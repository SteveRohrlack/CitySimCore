//
//  BudgetActor.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 23.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/**
 The BudgetActor manages all aspects of the budget but the current budget value.

 BudgetActor adopts the protocol "EventSubscribing"
 
 - holds sum of current running cost
 - event handler for "CityMap.add" and "CityMap.remove" for objects that are
   budgetable, subtracts cost to buy
 - substracts running cost
*/
class BudgetActor: Acting, EventSubscribing {
   
    /// actor stage
    /// simulation's main data container
    var stage: City
    
    init(stage: City) {
        self.stage = stage
    }
    
    /**
     Eventhandler for CityMapEvents
     
     - parameter event: the event type
     - parameter payload: the event data
    */
    func recieveEvent(event event: EventNaming, payload: Any) throws {
        guard let event = event as? CityMapEvents else {
            return
        }
        
        guard let budgetable = payload as? Budgetable else {
            return
        }
        
        switch event {
            case .AddTile:
                stage.totalRunningCost += budgetable.runningCost
            case .RemoveTile:
                stage.totalRunningCost -= budgetable.runningCost
        }
    }
    
    /**
     the BudgetActor subtracts the current total running cost from the budget
     */
    func act() {
        //subtract running cost
        stage.budget -= stage.totalRunningCost
        
    }
    
}
