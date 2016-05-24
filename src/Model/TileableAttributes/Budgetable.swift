//
//  Budgetable.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 23.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/// a Budgetable is an object that has associated cost and running cost
protocol Budgetable {
    
    /// cost have to be paid only once (example: buying a small park ploppable)
    var cost: Int { get }
    
    /// running cost have to be paid periodically
    var runningCost: Int { get }
}

/**
 A Budgetable may or may not contain it's own cost or running cost
 the default implementation is simply "0".
 This seems more convenient than making these properties "Optional" when
 adopting the protocol and simplifies the adoption.
*/
extension Budgetable {
    
    /// default value is "0"
    var cost: Int {
        return 0
    }
    
    /// default value is "0"
    var runningCost: Int {
        return 0
    }
    
}
