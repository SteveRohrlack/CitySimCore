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
    var cost: Int { get }
    var runningCost: Int { get }
}

/// a Budgetable may or may not contain it's own cost or running cost
/// the default implementation is simply "0"
/// this seems more convenient than setting these properites "Optional" when
/// adapting the protocol
extension Budgetable {
    var cost: Int {
        return 0
    }
    
    var runningCost: Int {
        return 0
    }
    
}
