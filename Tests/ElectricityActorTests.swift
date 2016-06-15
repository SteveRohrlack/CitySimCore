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
    
    var subject: Simulation?
    
    override func setUp() {
        super.setUp()
        
        let cityMap = CityMap(height: 25, width: 25)
        let city = City(map: cityMap, startingBudget: 50000)
        
        subject = Simulation(city: city)
        
        subject!.actors.append(
            ElectricityActor(stage: subject!.city)
        )
        
        /// adding streets
        do {
            try subject!.city.map.plopp(plopp: StreetPloppTestDouble(origin: (0, 0), height: 1, width: 10))
        } catch {
            XCTFail("should not fail")
        }
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testUpdatesElectricitySupply() {
        XCTAssertEqual(0, subject!.city.ressources.electricitySupply)

        /// adding electricity producer
        let producedElectricityAmount = 100
        let electricityProducer = ElectricityProducerPloppTestDouble(origin: (1, 0), producesAmount: producedElectricityAmount)
        do {
            try subject!.city.map.plopp(plopp: electricityProducer)
        } catch {
            XCTFail("should not fail")
        }
        
        XCTAssertEqual(producedElectricityAmount, subject!.city.ressources.electricitySupply)
        
        do {
            try subject!.city.map.removeAt(location: Location(origin: (1, 0)))
        } catch {
            XCTFail("should not fail")
        }
        
        XCTAssertEqual(0, subject!.city.ressources.electricitySupply)
    }
    
    func testUpdatesElectricityDemand() {
        XCTAssertEqual(0, subject!.city.ressources.electricityDemand)
        
        /// adding electricity consumer
        let consumedElectricityAmount = 100
        let electricityConsumer = ElectricityConsumerPloppTestDouble(origin: (1, 0), consumesAmount: consumedElectricityAmount)
        do {
            try subject!.city.map.plopp(plopp: electricityConsumer)
        } catch {
            XCTFail("should not fail")
        }
        
        XCTAssertEqual(consumedElectricityAmount, subject!.city.ressources.electricityDemand)
        
        do {
            try subject!.city.map.removeAt(location: Location(origin: (1, 0)))
        } catch {
            XCTFail("should not fail")
        }
        
        XCTAssertEqual(0, subject!.city.ressources.electricityDemand)
    }

    func testUpdatesConsumersIfNoProduction() {
        /// adding electricity consumer
        let consumedElectricityAmount = 100
        let electricityConsumer = ElectricityConsumerPloppTestDouble(origin: (1, 0), consumesAmount: consumedElectricityAmount)
        
        XCTAssertFalse(electricityConsumer.conditions.has(content: .NotPowered))
        
        do {
            try subject!.city.map.plopp(plopp: electricityConsumer)
        } catch {
            XCTFail("should not fail")
        }
        
        let modifiedElectricityConsumer = subject!.city.map.tileLayer[1, 0] as! Conditionable
        XCTAssertTrue(modifiedElectricityConsumer.conditions.has(content: .NotPowered))
    }
    
    func testUpdatesConsumersIfSufficientProduction() {
        /// adding electricity producer
        let producedElectricityAmount = 100
        let electricityProducer = ElectricityProducerPloppTestDouble(origin: (1, 0), producesAmount: producedElectricityAmount)
        do {
            try subject!.city.map.plopp(plopp: electricityProducer)
        } catch {
            XCTFail("should not fail")
        }
        
        /// adding electricity consumer
        let consumedElectricityAmount = producedElectricityAmount / 2
        
        let electricityConsumer1Origin = (1, electricityProducer.maxX + 1)
        let electricityConsumer1 = ElectricityConsumerPloppTestDouble(origin: electricityConsumer1Origin, consumesAmount: consumedElectricityAmount)
        
        let electricityConsumer2Origin = (1, electricityConsumer1.maxX + 1)
        let electricityConsumer2 = ElectricityConsumerPloppTestDouble(origin: electricityConsumer2Origin, consumesAmount: consumedElectricityAmount)
        
        do {
            try subject!.city.map.plopp(plopp: electricityConsumer1)
            try subject!.city.map.plopp(plopp: electricityConsumer2)
        } catch {
            XCTFail("should not fail")
        }
        
        let modifiedElectricityConsumer = subject!.city.map.tileLayer[electricityConsumer1Origin.0, electricityConsumer1Origin.1] as! Conditionable
        XCTAssertFalse(modifiedElectricityConsumer.conditions.has(content: .NotPowered))
    }

}
