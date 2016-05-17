//
//  StatisticsLayerTests.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 17.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import XCTest
@testable import CitySimCoreiOS

class StatisticsLayerTests: XCTestCase {
    
    var subject: StatisticsLayer?
    
    override func setUp() {
        super.setUp()
        
        subject = StatisticsLayer(rows: 5, columns: 5)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAdd() {
        subject!.add(
            at: Location(origin: (1, 1), height: 1, width: 1),
            radius: 1,
            value: 5
        )
        
        XCTAssertNotNil(subject![0, 0])
        XCTAssertNotNil(subject![2, 2])
    }
    
    func testAddMultipleForSameLocation() {
        subject!.add(
            at: Location(origin: (1, 1), height: 1, width: 1),
            radius: 1,
            value: 5
        )
        
        subject!.add(
            at: Location(origin: (1, 1), height: 1, width: 1),
            radius: 1,
            value: 5
        )
        
        XCTAssertEqual(10, subject![0, 0])
    }
    
    func testRemove() {
        subject!.add(
            at: Location(origin: (1, 1), height: 1, width: 1),
            radius: 1,
            value: 5
        )
        
        do {
            try subject!.remove(
                at: Location(origin: (1, 1), height: 1, width: 1),
                radius: 1,
                value: 5
            )
        } catch {
            XCTFail("should not fail")
        }
        
        XCTAssertNil(subject![0, 0])
    }
    
    func testRemoveWithRemains() {
        subject!.add(
            at: Location(origin: (1, 1), height: 1, width: 1),
            radius: 1,
            value: 5
        )
        
        subject!.add(
            at: Location(origin: (1, 1), height: 1, width: 1),
            radius: 1,
            value: 2
        )
        
        do {
            try subject!.remove(
                at: Location(origin: (1, 1), height: 1, width: 1),
                radius: 1,
                value: 4
            )
        } catch {
            XCTFail("should not fail")
        }
        
        XCTAssertEqual(3, subject![0, 0])
    }
    
    func testRemoveFails() {
        var errorOccured = false
        
        do {
            try subject!.remove(
                at: Location(origin: (1, 1), height: 1, width: 1),
                radius: 1,
                value: 5
            )
        } catch let e as StatisticsLayerError {
            XCTAssertEqual(e, StatisticsLayerError.CannotRemoveBecauseAlreadyEmpty)
            errorOccured = true
        } catch {
            XCTFail("wrong error")
        }
        
        if !errorOccured {
            XCTFail("should fail")
        }
    }
}