//
//  StatisticlayersContainerTests.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 20.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import XCTest

#if os(iOS)
    @testable import CitySimCoreiOS
#endif

#if os(OSX)
    @testable import CitySimCoreMacOS
#endif

class StatisticlayersContainerTests: XCTestCase {
    
    let height = 15
    let width = 15
    
    var subject: StatisticlayersContainer?
    
    override func setUp() {
        super.setUp()
        
        subject = StatisticlayersContainer(height: height, width: width)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLayerSize() {
        XCTAssertEqual(height * width, subject!.landvalueLayer.values.count)
    }
    
    func testAddStatistics() {
        let origin = (4, 4)
        let testDouble = SmallParkPloppTestDouble(origin: origin)
        
        subject!.addStatistics(
            at: Location(origin: origin),
            statistical: testDouble as MapStatistical
        )
        
        let testLocationWithRadius = testDouble + 3
        XCTAssertEqual(4, subject!.landvalueLayer[testLocationWithRadius.origin])
        
        XCTAssertNil(subject!.noiseLayer[testLocationWithRadius.origin])
    }
    
    func testRemoveStatistics() {
        let origin = (4, 4)
        let testDouble = SmallParkPloppTestDouble(origin: origin)
        
        subject!.addStatistics(
            at: Location(origin: origin),
            statistical: testDouble as MapStatistical
        )
        
        let testLocationWithRadius = testDouble + 3
        
        XCTAssertEqual(4, subject!.landvalueLayer[testLocationWithRadius.origin])
        
        subject!.removeStatistics(
            at: Location(origin: origin),
            statistical: testDouble as MapStatistical
        )
        
        XCTAssertNil(subject!.landvalueLayer[testLocationWithRadius.origin])
    }
    
}