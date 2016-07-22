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
public struct BudgetActor: Acting, EventSubscribing {
   
    typealias StageType = City
    
    /// actor stage
    /// simulation's main data container
    weak var stage: ActorStageable?
    
    /**
     initializer
     
     - parameter stage: City object work work with
    */
    init(stage: StageType) {
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
        guard let stage = stage as? StageType,
              let event = event as? CityMapEvent,
              let budgetable = payload as? Budgetable else {
            return
        }
        
        /// aggregate running cost in City.Budget
        if let runningCost = budgetable.runningCost {
            switch event {
            case .AddTile:
                stage.budget.runningCost += runningCost
            case .RemoveTile:
                stage.budget.runningCost -= runningCost
            }
        }
        
        /// subtract one-time cost from budget
        if let cost = budgetable.cost {
            if case .AddTile = event {
                stage.budget.amount -= cost
            }
        }
    }
    
    /**
     the BudgetActor subtracts the current total running cost from the budget
     
     - parameter tick: the current simulation tick
     */
    func act(tick tick: Int) {
        guard let stage = stage as? StageType else {
            return
        }

        /// subtract running cost
        stage.budget.amount -= stage.budget.runningCost
    }
    
}
