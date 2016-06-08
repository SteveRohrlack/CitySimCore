//
//  RessourceTypeTests.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 08.06.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import XCTest
@testable import CitySimCoreiOS

class RessourceTypeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testOperatorGreaterEqual() {
        let ressourceType1: RessourceType = .Electricity(10)
        let ressourceType2: RessourceType = .Electricity(20)
        let ressourceTypeNil: RessourceType = .Electricity(nil)
        
        XCTAssertEqual(true, ressourceType1 <= ressourceType2)
        XCTAssertEqual(false, ressourceType1 <= ressourceTypeNil)
    }
    
    func testOperatorLesserEqual() {
        let ressourceType1: RessourceType = .Electricity(10)
        let ressourceType2: RessourceType = .Electricity(20)
        let ressourceTypeNil: RessourceType = .Electricity(nil)
        
        XCTAssertEqual(true, ressourceType1 <= ressourceType2)
        XCTAssertEqual(false, ressourceType1 <= ressourceTypeNil)
    }
    
    func testOperatorEqual() {
        let ressourceType1: RessourceType = .Electricity(10)
        let ressourceType2: RessourceType = .Electricity(10)
        let ressourceTypeNil: RessourceType = .Electricity(nil)
        
        XCTAssertEqual(true, ressourceType1 == ressourceType2)
        XCTAssertEqual(false, ressourceType1 == ressourceTypeNil)
        XCTAssertEqual(false, ressourceType1 != ressourceType2)
    }
    
    func testConsumerConsumes() {
        let ressourceConsumer = RessourceConsumerTestDouble(ressources: [.Electricity(1)])
        
        XCTAssertEqual(true, ressourceConsumer.consumes(ressource: .Electricity(nil)))
        XCTAssertEqual(false, ressourceConsumer.consumes(ressource: .Water(nil)))
    }
    
}