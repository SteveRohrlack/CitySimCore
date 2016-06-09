//
//  MapStatisticTests.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 09.06.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import XCTest

#if os(iOS)
    @testable import CitySimCoreiOS
#endif

#if os(OSX)
    @testable import CitySimCoreMacOS
#endif

class MapStatisticTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testOperatorEqual() {
        let mapStatistic1: MapStatistic = .Landvalue(radius: 1, value: 1)
        let mapStatistic2: MapStatistic = .Landvalue(radius: 1, value: 1)
        XCTAssertEqual(true, mapStatistic1 == mapStatistic2)
        
        let mapStatistic3: MapStatistic = .Landvalue(radius: 2, value: 1)
        XCTAssertEqual(false, mapStatistic1 == mapStatistic3)
        
        let mapStatistic4: MapStatistic = .Landvalue(radius: 1, value: 2)
        XCTAssertEqual(false, mapStatistic1 == mapStatistic4)
        
        let mapStatistic5: MapStatistic = .Noise(radius: 1, value: 1)
        XCTAssertEqual(false, mapStatistic1 == mapStatistic5)
    }
    
}