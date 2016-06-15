//
//  BudgetableTests.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 15.06.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import XCTest

#if os(iOS)
    @testable import CitySimCoreiOS
#endif

#if os(OSX)
    @testable import CitySimCoreMacOS
#endif

class BudgetableTests: XCTestCase {
    
    var subject: Simulation?
    
    override func setUp() {
        super.setUp()
        
        let cityMap = CityMap(height: 1, width: 1)
        let city = City(map: cityMap, startingBudget: 50000)
        
        subject = Simulation(city: city)
        
        subject!.actors.append(
            BudgetActor(stage: subject!.city)
        )
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSubtractsCost() {
        let startingBudget = subject!.city.budget.amount
        let budgetable = BudgetablePloppTestDouble(origin: (0, 0), height: 1, width: 1)
        
        do {
            try subject!.city.map.plopp(plopp: budgetable)
        } catch {
            XCTFail("should not fail")
        }
        
        XCTAssertEqual(startingBudget - budgetable.cost!, subject!.city.budget.amount)
    }
    
    func testSubtractsRunningCost() {
        let budgetable = BudgetablePloppTestDouble(origin: (0, 0), height: 1, width: 1)
        
        XCTAssertEqual(0, subject!.city.budget.runningCost)
        
        do {
            try subject!.city.map.plopp(plopp: budgetable)
        } catch {
            XCTFail("should not fail")
        }
        
        XCTAssertEqual(budgetable.runningCost!, subject!.city.budget.runningCost)

        let budgetAmount = subject!.city.budget.amount
        subject!.advance()
        
        XCTAssertEqual(budgetAmount - budgetable.runningCost!, subject!.city.budget.amount)
    }
    
}