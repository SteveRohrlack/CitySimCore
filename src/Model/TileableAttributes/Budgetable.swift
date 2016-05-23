//
//  Budgetable.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 23.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

protocol Budgetable {
    var cost: Int { get }
    var runningCost: Int { get }
}

extension Budgetable {
    var cost: Int {
        return 0
    }
    
    var runningCost: Int {
        return 0
    }
    
}
