//
//  TrafficLayerTests.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 22.07.16.
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

class TrafficLayerTests: XCTestCase {
    
    var subject: GKGridGraph?
    
    override func setUp() {
        super.setUp()
        
        let gridWidth = 10
        let gridHeight = 10
        
        subject = GKGridGraph(fromGridStartingAt: vector_int2(0, 0), width: Int32(gridWidth), height: Int32(gridHeight), diagonalsAllowed: false)
        
        //empty graph
        if let nodes = subject?.nodes {
            subject?.removeNodes(nodes)
        }
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSetup() {
        XCTAssertEqual(0, subject?.nodes?.count)
    }
    
    func testAddLocation() {
        let location = Location(origin: (0, 0), height: 1, width: 10)

        subject?.add(location: location)
        
        XCTAssertEqual(location.nodes.count, subject?.nodes?.count)
    }
    
    func testRemoveLocation() {
        let location = Location(origin: (0, 0), height: 1, width: 10)
        subject?.add(location: location)
            
        subject?.remove(location: location)
            
        XCTAssertEqual(0, subject?.nodes?.count)
    }
    
    func testNodeAtLocation() {
        let location = Location(origin: (0, 0), height: 1, width: 10)
        subject?.add(location: location)
        
        let query = Location(origin: (0, 0), height: 1, width: 1)
        
        XCTAssertNotNil(subject?.nodeAtGridPosition(location: query))
    }
    
    func testPathfinding() {
        // for example: adding streets
        let streets1 = Location(origin: (0, 0), height: 1, width: 10)
        subject?.add(location: streets1)
        
        let streets2 = Location(origin: (1, 9), height: 9, width: 1)
        subject?.add(location: streets2)
        
        let startNode = subject?.nodeAtGridPosition(vector_int2(Int32(streets1.originX), Int32(streets1.originY)))
        let endNode = subject?.nodeAtGridPosition(vector_int2(Int32(streets2.maxX), Int32(streets2.maxY)))
        
        let path = subject?.findPathFromNode(startNode!, toNode: endNode!)
        
        XCTAssertEqual(19, path?.count)
    }
    
    func testPathfindingFails() {
        // for example: adding streets
        let streets1 = Location(origin: (0, 0), height: 1, width: 1)
        subject?.add(location: streets1)
        
        let streets2 = Location(origin: (9, 9), height: 1, width: 1)
        subject?.add(location: streets2)
        
        let startNode = subject?.nodeAtGridPosition(vector_int2(Int32(streets1.originX), Int32(streets1.originY)))
        let endNode = subject?.nodeAtGridPosition(vector_int2(Int32(streets2.originX), Int32(streets2.originY)))
        
        let path = subject?.findPathFromNode(startNode!, toNode: endNode!)
        
        XCTAssertEqual(0, path?.count)
    }
}