//
//  BudgetablePloppTestDouble.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 10.06.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

#if os(iOS)
    @testable import CitySimCoreiOS
#endif

#if os(OSX)
    @testable import CitySimCoreMacOS
#endif

struct BudgetablePloppTestDouble: Ploppable, Budgetable {
    let origin: (Int, Int)
    let height: Int
    let width: Int
    var name = "BudgetablePlopp"
    let description = "BudgetablePlopp"
    let cost: Int? = 10
    let runningCost: Int? = 10
    let type: TileType = .Ploppable(.Street)
    
    init(origin: (Int, Int), height: Int, width: Int) {
        self.origin = origin
        self.height = height
        self.width = width
    }

}
