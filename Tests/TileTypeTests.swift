//
//  TileTypeTests.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import XCTest
@testable import CitySimCoreiOS

class TileTypeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testOperatorEqual() {
        let tileType1: TileType = .Zoneable(.Residential)
        let tileType2: TileType = .Zoneable(.Residential)
        
        XCTAssertEqual(true, tileType1 == tileType2)
    }
    
}