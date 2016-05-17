//
//  TileMapTests.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import XCTest
@testable import CitySimCoreiOS

class TileMapTests: XCTestCase {
    
    var subject: TileLayer?
    
    override func setUp() {
        super.setUp()
        
        subject = TileLayer(rows: 5, columns: 5)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSubscriptGet() {
        let content = subject![0,0]
        XCTAssertNil(content)
    }
    
    func testSubscriptSet() {
        subject![0,0] = Zone(origin: (0,0), height: 1, width: 1, type: .Zoneable(.Residential))
        XCTAssertNotNil(subject![0,0])
        XCTAssertNil(subject![1,0])
    }
    
    func testAddTile() {
        let tile = Zone(origin: (1,1), height: 2, width: 2, type: .Zoneable(.Residential))
        
        do {
            try subject!.addTile(tile: tile)
        }
        catch {
            XCTFail("should not fail")
        }
        
        for y in 1...2 {
            for x in 1...2 {
                guard let _ = subject![y,x] else {
                    XCTFail("tile missing")
                    continue
                }
            }
        }
        
        XCTAssertNil(subject![0,0])
        XCTAssertNil(subject![0,1])
        XCTAssertNil(subject![1,0])
        
        XCTAssertNil(subject![3,0])
        XCTAssertNil(subject![3,1])
        XCTAssertNil(subject![3,2])
        XCTAssertNil(subject![3,3])
        
        XCTAssertNil(subject![0,3])
        XCTAssertNil(subject![1,3])
        XCTAssertNil(subject![2,3])
    }
    
    func testAddTileFails() {
        let tile = Zone(origin: (4,4), height: 2, width: 2, type: .Zoneable(.Residential))
        var errorOccured = false
        
        do {
            try subject!.addTile(tile: tile)
        }
        catch let e as TileableMapError {
            XCTAssertEqual(e, TileableMapError.TileCantFit)
            errorOccured = true
        }
        catch {
            XCTFail("wrong error")
        }
        
        if !errorOccured {
            XCTFail("should fail")
        }
    }
    
    func testUsedByTilesAt() {
        let tile1 = Zone(origin: (0,0), height: 1, width: 1, type: .Zoneable(.Residential))
        let tile2 = Zone(origin: (1,1), height: 1, width: 1, type: .Zoneable(.Commercial))
        
        do {
            try subject!.addTile(tile: tile1)
            try subject!.addTile(tile: tile2)
        } catch {
            XCTFail("should not fail")
        }
        
        let tiles = subject!.usedByTilesAt(location: Location(origin: (0,0), height: 2, width: 2))
        
        XCTAssertEqual(2, tiles.count)
    }
}
