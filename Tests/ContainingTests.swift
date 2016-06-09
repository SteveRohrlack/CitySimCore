//
//  ContainingTests.swift
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

class ContainingTests: XCTestCase {
    
    var subject: ContainingTestDouble?
    
    override func setUp() {
        super.setUp()
        
        subject = ContainingTestDouble()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAdd() {
        subject!.add(content: "new1")
        XCTAssertEqual(1, subject!.containerContent.count)
        XCTAssertEqual("new1", subject!.containerContent.first)
        
        subject!.add(content: "new1")
        XCTAssertEqual(1, subject!.containerContent.count)
        
        subject!.add(content: "new2")
        XCTAssertEqual(2, subject!.containerContent.count)
        
    }
    
    func testRemove() {
        subject!.add(content: "new1")
        subject!.add(content: "new2")
        
        subject!.remove(content: "new1")
        subject!.remove(content: "unknown")
        XCTAssertEqual(1, subject!.containerContent.count)
        XCTAssertEqual("new2", subject!.containerContent.first)
    }
    
    func testHas() {
        subject!.add(content: "new1")
        
        XCTAssertEqual(true, subject!.has(content: "new1"))
        XCTAssertEqual(false, subject!.has(content: "new2"))
    }
    
}