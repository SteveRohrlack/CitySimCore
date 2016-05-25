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
 
 - holds list of budgetable objects
 - event handler for "CityMap.add" and "CityMap.remove" for objects that are
   budgetable, subtracts cost to buy
 - substracts running costs of all budgetables
*/
struct BudgetActor: Acting, EventSubscribing {
   
    /// list of budgetable objects
    var budgetables: [Budgetable]
    
    /// event subscriber id for referencing
    let eventSubscriberId = "BudgetActor"
    
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
                break //budgetables.append(budgetable)
            case .RemoveTile:
                break
        }
    }
    
    /**
     the BudgetActor subtracts the running cost of all registered budgetables
     from the overall budget
     
     - parameter stage: City object
     */
    mutating func act(stage city: City) {
        //subtract running cost
        for budgetable in budgetables {
            city.budget -= budgetable.runningCost
        }
        
    }
    
}
