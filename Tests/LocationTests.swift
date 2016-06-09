//
//  LocationTests.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import XCTest

#if os(iOS)
    @testable import CitySimCoreiOS
#endif

#if os(OSX)
    @testable import CitySimCoreMacOS
#endif

class LocationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testOperatorAddInt() {
        let location = Location(origin: (5, 5), height: 1, width: 1)
        
        let radius = 1
        
        let newLocation = location + radius
        
        XCTAssertEqual(newLocation.originY, location.originY - radius)
        XCTAssertEqual(newLocation.originX, location.originX - radius)
        XCTAssertEqual(newLocation.height, location.height + (radius * 2))
        XCTAssertEqual(newLocation.width, location.width + (radius * 2))
    }
    
    func testOperatorEqual() {
        let location1 = Location(origin: (1, 1), height: 1, width: 1)
        let location2 = Location(origin: (1, 1), height: 1, width: 1)
        XCTAssertEqual(true, location1 == location2)
        
        let location3 = Location(origin: (2, 1), height: 1, width: 1)
        XCTAssertEqual(false, location1 == location3)
        
        let location4 = Location(origin: (1, 2), height: 1, width: 1)
        XCTAssertEqual(false, location1 == location4)
        
        let location5 = Location(origin: (1, 1), height: 2, width: 1)
        XCTAssertEqual(false, location1 == location5)
        
        let location6 = Location(origin: (1, 1), height: 1, width: 2)
        XCTAssertEqual(false, location1 == location6)
    }
    
}