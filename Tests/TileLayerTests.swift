//
//  TileMapTests.swift
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

class TileLayerTests: XCTestCase {
    
    var subject: TileLayer?
    
    override func setUp() {
        super.setUp()
        
        subject = TileLayer(rows: 5, columns: 5)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSubscriptGet() {
        let content = subject![0, 0]
        XCTAssertNil(content)
    }
    
    func testSubscriptSet() {
        subject![0, 0] = SmallResidentialZoneTestDouble(origin: (0, 0))
        XCTAssertNotNil(subject![0, 0])
        XCTAssertNil(subject![1, 0])
    }
    
    func testAddTile() {
        let tile = SmallResidentialZoneTestDouble(origin: (1, 1))
        
        do {
            try subject!.add(tile: tile)
        }
        catch {
            XCTFail("should not fail")
        }
        
        for y in 1...2 {
            for x in 1...2 {
                guard let _ = subject![y, x] else {
                    XCTFail("tile missing")
                    continue
                }
            }
        }
        
        XCTAssertNil(subject![0, 0])
        XCTAssertNil(subject![0, 1])
        XCTAssertNil(subject![1, 0])
        
        XCTAssertNil(subject![3, 0])
        XCTAssertNil(subject![3, 1])
        XCTAssertNil(subject![3, 2])
        XCTAssertNil(subject![3, 3])
        
        XCTAssertNil(subject![0, 3])
        XCTAssertNil(subject![1, 3])
        XCTAssertNil(subject![2, 3])
    }
    
    func testAddTileFails() {
        let tile = SmallResidentialZoneTestDouble(origin: (4, 4))
        var errorOccured = false
        
        do {
            try subject!.add(tile: tile)
        } catch let e as TileLayerError {
            XCTAssertEqual(e, TileLayerError.TileCantFit)
            errorOccured = true
        } catch {
            XCTFail("wrong error")
        }
        
        if !errorOccured {
            XCTFail("should fail")
        }
    }
       
    func testUsedByTilesAt() {
        let tile1 = SmallResidentialZoneTestDouble(origin: (0, 0))
        let tile2 = SmallResidentialZoneTestDouble(origin: (2, 2))
        
        do {
            try subject!.add(tile: tile1)
            try subject!.add(tile: tile2)
        } catch {
            XCTFail("should not fail")
        }
        
        let tiles = subject!.usedByTilesAt(location: Location(origin: (0, 0), height: 3, width: 3))
        
        XCTAssertEqual(2, tiles.count)
    }
    
    func testFilter() {
        let tile1 = SmallResidentialZoneTestDouble(origin: (0, 0))
        let tile2 = SmallParkPloppTestDouble(origin: (2, 2))
        
        do {
            try subject!.add(tile: tile1)
            try subject!.add(tile: tile2)
        } catch {
            XCTFail("should not fail")
        }
        
        let tiles = subject!.filter { (tile) in
            return tile is RessourceConsuming
        }
        
        XCTAssertEqual(1, tiles.count)
    }

}
