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
    
}