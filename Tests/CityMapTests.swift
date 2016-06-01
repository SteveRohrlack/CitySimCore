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
    
}