//
//  CityMapTests.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 01.06.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import XCTest
@testable import CitySimCoreiOS

class CityMapTests: XCTestCase {
    
    var subject: CityMap?
    
    override func setUp() {
        super.setUp()
        
        subject = CityMap(height: 5, width: 5)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCanAdd() {       
        let tile = SmallResidentialZoneTestDouble(origin: (1, 1))
        
        do {
            try subject!.canAdd(tile: tile)
        } catch {
            XCTFail("should not fail")
        }
    }
    
    func testCanAddFailsBecauseCannotFit() {
        let tile = SmallResidentialZoneTestDouble(origin: (subject!.height - 1, subject!.width - 1))
        
        do {
            try subject!.canAdd(tile: tile)
        } catch let e as CityMapError {
            XCTAssertEqual(e, CityMapError.TileCantFit)
        } catch {
            XCTFail("wrong error")
        }
    }
    
    func testCanAddFailsBecauseNotEmpty() {
        let tile = SmallResidentialZoneTestDouble(origin: (0, 0))
        
        do {
            try subject!.canAdd(tile: tile)
        } catch {
            XCTFail("should not fail")
        }
        
        do {
            try subject!.canAdd(tile: tile)
        } catch let e as CityMapError {
            XCTAssertEqual(e, CityMapError.CannotAddBecauseNotEmpty)
        } catch {
            XCTFail("wrong error")
        }
    }
    
    func testCanAddFailsBecauseNotNearStreet() {
        let tile = PlaceNearStreetTestDouble(origin: (0, 0))
        
        do {
            try subject!.canAdd(tile: tile)
        } catch let e as CityMapError {
            XCTAssertEqual(e, CityMapError.PlaceNearStreet)
        } catch {
            XCTFail("wrong error")
        }
    }
}