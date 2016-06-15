//
//  CitySimCore.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 15.06.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import XCTest

#if os(iOS)
    @testable import CitySimCoreiOS
#endif

#if os(OSX)
    @testable import CitySimCoreMacOS
#endif

class CitySimCoreTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testUsecase() {
        let cityMap = CityMap(height: 25, width: 25)
        let city = City(map: cityMap, startingBudget: 50000)
        var simulation = Simulation(city: city)
        
        simulation.actors.append(
            BudgetActor(stage: city)
        )
        
        simulation.actors.append(
            ElectricityActor(stage: city)
        )
        
        simulation.advance()
        
        /// adding streets
        do {
            try city.map.plopp(plopp: StreetPloppTestDouble(origin: (0, 0), height: 10, width: 1))
            try city.map.plopp(plopp: StreetPloppTestDouble(origin: (0, 1), height: 1, width: 9))
        } catch {
            XCTFail("should not fail")
        }
        
        /// adding electricity consumer
        let electricityConsumer = ElectricityConsumerTestDouble(origin: (1, 1));
        do {
            try city.map.plopp(plopp: electricityConsumer)
        } catch {
            XCTFail("should not fail")
        }
        
        simulation.advance()
        
        /// adding electricity producer
        let electricityProducer = ElectricityProducerTestDouble(origin: (electricityConsumer.originY, electricityConsumer.maxX + 1))
        do {
            try city.map.plopp(plopp: electricityProducer)
        } catch {
            XCTFail("should not fail")
        }

        simulation.advance()
    }
}