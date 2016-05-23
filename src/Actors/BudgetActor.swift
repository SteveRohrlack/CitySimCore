//
//  BudgetActor.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 23.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/**
 - manages budget
 - holds list of budgetable objects
 - event handler for "CityMap.add" and "CityMap.remove" for objects that are
   budgetable, subtracts cost to buy
 - runningCosts of all budgetables are subtracted
*/
struct BudgetActor: Acting {
    
    var currentBudget: Int
    var budgetables: [Budgetable]
    
    mutating func act(on map: CityMap) {
        //subtract running cost
        for budgetable in budgetables {
            currentBudget -= budgetable.runningCost
        }
        
    }
    
}
