//
//  StatisticlayersContainerTests.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 20.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

import XCTest
@testable import CitySimCoreiOS

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
    
    func testremoveStatistics() {
        let origin = (4, 4)
        let testDouble = SmallParkPloppTestDouble(origin: origin)
        
        subject!.addStatistics(
            at: Location(origin: origin),
            statistical: testDouble as MapStatistical
        )
        
        let testLocationWithRadius = testDouble + 3
        
        XCTAssertEqual(4, subject!.landvalueLayer[testLocationWithRadius.origin])
        
        do {
            try subject!.removeStatistics(
                at: Location(origin: origin),
                statistical: testDouble as MapStatistical
            )
        } catch {
            XCTFail("should not fail")
        }

        
        XCTAssertNil(subject!.landvalueLayer[testLocationWithRadius.origin])
    }
    
}