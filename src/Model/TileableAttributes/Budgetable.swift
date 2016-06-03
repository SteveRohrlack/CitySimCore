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
    var cost: Int? { get }
    
    /// running cost have to be paid periodically
    var runningCost: Int? { get }
}
