//
//  SimulationTests.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 06.06.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import XCTest
@testable import CitySimCoreiOS

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
}