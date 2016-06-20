//
//  CityMapTests.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 01.06.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import XCTest
import GameplayKit

#if os(iOS)
    @testable import CitySimCoreiOS
#endif

#if os(OSX)
    @testable import CitySimCoreMacOS
#endif

class CityMapTests: XCTestCase {
    
    var subject: CityMap?
    
    override func setUp() {
        super.setUp()
        
        subject = CityMap(height: 5, width: 5)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /// MARK: canAdd
    
    func testCanAdd() {       
        let tile = ZoneTestDouble(origin: (1, 1))
        
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
        let tile = ZoneTestDouble(origin: (0, 0))
        
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
        let tile = PlaceNearStreetZoneTestDouble(origin: (0, 0))
        
        do {
            try subject!.canAdd(tile: tile)
        } catch let e as CityMapError {
            XCTAssertEqual(e, CityMapError.PlaceNearStreet)
        } catch {
            XCTFail("wrong error")
        }
    }
    
    /// MARK: adding tiles
    
    func testAddZone() {
        do {
            try subject!.plopp(plopp: StreetPloppTestDouble(origin: (0, 0), height: 1, width: 1))
            try subject!.zone(zone: SmallResidentialZoneTestDouble(origin: (1, 1)))
        } catch {
            XCTFail("should not fail")
        }
        
        XCTAssertNotNil(subject!.tileLayer[1, 1])
    }
    
    func testAddPlopp() {
        do {
            try subject!.plopp(plopp: StreetPloppTestDouble(origin: (0, 0), height: 1, width: 1))
        } catch {
            XCTFail("should not fail")
        }
        
        XCTAssertNotNil(subject!.tileLayer[0, 0])
    }
    
    func testAddProp() {
        do {
            try subject!.prop(prop: WaterPropTestDouble(origin: (0, 0), height: 1, width: 1, content: 1))
        } catch {
            XCTFail("should not fail")
        }
        
        XCTAssertNotNil(subject!.tileLayer[0, 0])
    }
    
    func testAddRessourceCarrying() {
        let streetPlopp = StreetPloppTestDouble(origin: (0, 0), height: 1, width: 2)
        
        do {
            try subject!.plopp(plopp: streetPlopp)
        } catch {
            XCTFail("should not fail")
        }
        
        streetPlopp.forEachCell { (y: Int, x: Int) in
            let node = self.subject!.graph.nodeAtGridPosition(vector_int2(Int32(y), Int32(x)))
            XCTAssertNotNil(node)
        }
        
        let nodeNil: GKGridGraphNode? = subject!.graph.nodeAtGridPosition(vector_int2(Int32(streetPlopp.originY + 1), Int32(streetPlopp.originX + 2)))
        
        guard let _ = nodeNil else {
            XCTFail("node should not exist")
            return
        }
    }
    
    /// MARK: remove, info
    
    func testInfoAt() {
        let testLocation = Location(origin: (0, 0), width: 3, height: 3)
        
        var tiles = subject!.infoAt(location: testLocation)
        XCTAssertEqual(0, tiles.count)
        
        do {
            try subject!.plopp(plopp: StreetPloppTestDouble(origin: (0, 2), height: 1, width: 3))
            try subject!.plopp(plopp: StreetPloppTestDouble(origin: (1, 1), height: 1, width: 1))
            try subject!.prop(prop: WaterPropTestDouble(origin: (2, 2), height: 1, width: 1, content: 1))
            
            //out of location
            try subject!.plopp(plopp: StreetPloppTestDouble(origin: (3, 3), height: 1, width: 1))
        } catch {
            XCTFail("should not fail")
        }
        
        tiles = subject!.infoAt(location: testLocation)
        XCTAssertEqual(3, tiles.count)
    }
    
    func testCanRemoveAt() {
        do {
            try subject!.prop(prop: NotRemoveablePropTestDouble(origin: (0, 0)))
        } catch {
            XCTFail("should not fail")
        }
        
        do {
            try subject!.canRemoveAt(location: Location(origin: (0, 0), height: 1, width: 1))
        } catch let e as CityMapError {
            XCTAssertEqual(e, CityMapError.TileNotRemoveable)
        } catch {
            XCTFail("wrong error")
        }
    }
    
    func testRemoveAt() {
        do {
            try subject!.plopp(plopp: StreetPloppTestDouble(origin: (0, 0), height: 1, width: 1))
        } catch {
            XCTFail("should not fail")
        }
        
        do {
            try subject!.removeAt(location: Location(origin: (0, 0), height: 1, width: 1))
        } catch {
            XCTFail("should not fail")
        }
        
        XCTAssertNil(subject!.tileLayer[0, 0])
    }
    
    func testRemoveRessourceCarrying() {
        let location = Location(origin: (0, 0))
        
        let streetPlopp = StreetPloppTestDouble(origin: location.origin, height: 1, width: 2)
        
        do {
            try subject!.plopp(plopp: streetPlopp)
            try subject!.removeAt(location: location)
        } catch {
            XCTFail("should not fail")
        }
        
        streetPlopp.forEachCell { (y: Int, x: Int) in
            let nodeNil: GKGridGraphNode? = self.subject!.graph.nodeAtGridPosition(vector_int2(Int32(y), Int32(x)))
            guard let _ = nodeNil else {
                return
            }
            
            XCTFail("node should not exist")
        }
    }
    
    /// MARK: events
    
    func testEmitsAddTile() {
        
        func eventHandler(event: EventNaming, payload: Any) -> Void {
            guard let event = event as? CityMapEvent else {
                XCTFail("wrong event type")
                return
            }
            
            XCTAssertEqual(CityMapEvent.AddTile, event)
        }
        
        let subscriber = EventSubscriberTestDouble(eventHandler: eventHandler)
        subject!.subscribe(subscriber: subscriber, to: CityMapEvent.AddTile)
        
        do {
            try subject!.plopp(plopp: StreetPloppTestDouble(origin: (0, 0), height: 1, width: 1))
        } catch {
            XCTFail("should not fail")
        }
        
        XCTAssertEqual(1, subscriber.callTimes)
    }
    
    func testEmitsRemoveTile() {
        
        func eventHandler(event: EventNaming, payload: Any) -> Void {
            guard let event = event as? CityMapEvent else {
                XCTFail("wrong event type")
                return
            }
            
            XCTAssertEqual(CityMapEvent.RemoveTile, event)
        }
        
        let subscriber = EventSubscriberTestDouble(eventHandler: eventHandler)
        subject!.subscribe(subscriber: subscriber, to: CityMapEvent.RemoveTile)
        
        do {
            try subject!.plopp(plopp: StreetPloppTestDouble(origin: (0, 0), height: 1, width: 1))
            try subject!.removeAt(location: Location(origin: (0, 0), height: 1, width: 1))
        } catch {
            XCTFail("should not fail")
        }
        
        XCTAssertEqual(1, subscriber.callTimes)
    }
    
}