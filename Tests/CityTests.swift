//
//  CityTests.swift
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

class CityTests: XCTestCase {
    
    var subject: City?
    
    override func setUp() {
        super.setUp()
        
        let cityMap = CityMap(height: 1, width: 1)
        subject = City(map: cityMap, startingBudget: 1, populationThresholds: [1, 5])
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /// MARK: events
    
    func testEmitsPopulationReachedThreshold() {
        
        func eventHandler(event: EventNaming, payload: Any) -> Void {
            guard let event = event as? CityEvent else {
                XCTFail("wrong event type")
                return
            }
            
            XCTAssertEqual(CityEvent.PopulationReachedThreshold, event)
        }
        
        let subscriber = EventSubscriberTestDouble(eventHandler: eventHandler)
        subject!.subscribe(subscriber: subscriber, to: CityEvent.PopulationReachedThreshold)
        
        subject!.population = 1
        XCTAssertEqual(1, subscriber.callTimes)
        
        subject!.population = 2
        XCTAssertEqual(1, subscriber.callTimes)
        
        subject!.population = 5
        XCTAssertEqual(2, subscriber.callTimes)
        
        subject!.population = 4
        XCTAssertEqual(2, subscriber.callTimes)
        
        subject!.population = 6
        XCTAssertEqual(3, subscriber.callTimes)
    }
    
}