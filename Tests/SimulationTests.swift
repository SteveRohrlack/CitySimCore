//
//  SimulationTests.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 06.06.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import XCTest

#if os(iOS)
    @testable import CitySimCoreiOS
#endif

#if os(OSX)
    @testable import CitySimCoreMacOS
#endif

class SimulationTests: XCTestCase {
    
    var subject: Simulation?
    
    override func setUp() {
        super.setUp()
        
        let cityMap = CityMap(height: 1024, width: 1024)
        let city = City(map: cityMap, startingBudget: 50000)
        
        subject = Simulation(city: city)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTicks() {
        XCTAssertEqual(0, subject!.ticks)
        
        subject!.advance()
        
        XCTAssertEqual(1, subject!.ticks)
    }
    
    func testAdvances() {
        subject!.actors.append(
            BudgetActor(stage: subject!.city)
        )
        
        let startingBudget = subject!.city.budget.amount
        let budgetable = BudgetablePloppTestDouble(origin: (0, 0), height: 1, width: 1)
        
        do {
            try subject!.city.map.plopp(plopp: budgetable)
        } catch {
            XCTFail("should not fail")
        }
        
        XCTAssertEqual(budgetable.runningCost!, subject!.city.budget.runningCost)
        XCTAssertEqual(startingBudget - budgetable.cost!, subject!.city.budget.amount)
        
        subject!.advance()
        
        XCTAssertEqual(budgetable.runningCost!, subject!.city.budget.runningCost)
        XCTAssertEqual(startingBudget - (budgetable.cost! * 2), subject!.city.budget.amount)
    }
    
}