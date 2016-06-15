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
        
        let cityMap = CityMap(height: 1, width: 1)
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