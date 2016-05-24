//
//  BudgetActor.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 23.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/**
 the BudgetActor manages all aspects of the budget

 BudgetActor adopts the protocol "EventSubscribing"
 
 - holds list of budgetable objects
 - event handler for "CityMap.add" and "CityMap.remove" for objects that are
   budgetable, subtracts cost to buy
 - substracts running costs of all budgetables
*/
struct BudgetActor: Acting, EventSubscribing {
    
    /// the current budget
    var currentBudget: Int
    
    /// list of budgetable objects
    var budgetables: [Budgetable]
    
    /// event subscriber id for referencing
    let eventSubscriberId = "BudgetActor"
    
    /// Eventhandler for CityMapEvents
    func recieveEvent(event event: EventNaming, payload: Any) throws {
        guard let event = event as? CityMapEvents else {
            return
        }
        
        guard payload is Budgetable else {
            return
        }
        
        switch event {
            case .AddTile:
                break
            case .RemoveTile:
                break
        }
    }
    
    mutating func act(on map: CityMap) {
        //subtract running cost
        for budgetable in budgetables {
            currentBudget -= budgetable.runningCost
        }
        
    }
    
}
