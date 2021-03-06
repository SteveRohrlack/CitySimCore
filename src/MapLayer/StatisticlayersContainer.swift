//
//  StatisticlayersContainer.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 17.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/**
 the StatisticlayersContainer provides a convenience api for working with
 different StatisticsLayer instances
*/
public struct StatisticlayersContainer {
    
    /// layer for Landvalue
    public var landvalueLayer: StatisticsLayer
    
    /// layer for Noise
    public var noiseLayer: StatisticsLayer
    
    /// layer for Firesafety
    public var firesafetyLayer: StatisticsLayer
    
    /// layer for Crime
    public var crimeLayer: StatisticsLayer
    
    /// layer for Crime
    public var healthLayer: StatisticsLayer
    
    /**
     initializer
     
     - parameter height: needed to create specific map layers
     - parameter width: needed to create specific map layers
    */
    init(height: Int, width: Int) {
        self.landvalueLayer = StatisticsLayer(rows: height, columns: width)
        self.noiseLayer = StatisticsLayer(rows: height, columns: width)
        self.firesafetyLayer = StatisticsLayer(rows: height, columns: width)
        self.crimeLayer = StatisticsLayer(rows: height, columns: width)
        self.healthLayer = StatisticsLayer(rows: height, columns: width)
    }
    
    /**
     add statistic values
     
     decides what layer the given statistics should be added to based on each
     statistics type
     
     - parameter at: location
     - parameter statistical: container of type MapStatistical holding statistics
    */
    mutating func addStatistics(at location: Locateable, statistical: MapStatistical) {
        for statistic in statistical.statistics.containerContent {
            switch statistic {
            case .Landvalue(let radius, let value):
                landvalueLayer.add(at: location, radius: radius, value: value)
            case .Noise(let radius, let value):
                noiseLayer.add(at: location, radius: radius, value: value)
            case .Firesafety(let radius, let value):
                firesafetyLayer.add(at: location, radius: radius, value: value)
            case .Crime(let radius, let value):
                crimeLayer.add(at: location, radius: radius, value: value)
            case .Health(let radius, let value):
                healthLayer.add(at: location, radius: radius, value: value)
            }
        }
    }
    
    /**
     remove statistic values
     
     decides what layer the given statistics should be removed from based on each
     statistics type
     
     - parameter at: location
     - parameter statistical: container of type MapStatistical holding statistics
    */
    mutating func removeStatistics(at location: Locateable, statistical: MapStatistical) {
        for statistic in statistical.statistics.containerContent {
            switch statistic {
            case .Landvalue(let radius, let value):
                landvalueLayer.remove(at: location, radius: radius, value: value)
            case .Noise(let radius, let value):
                noiseLayer.remove(at: location, radius: radius, value: value)
            case .Firesafety(let radius, let value):
                firesafetyLayer.remove(at: location, radius: radius, value: value)
            case .Crime(let radius, let value):
                crimeLayer.remove(at: location, radius: radius, value: value)
            case .Health(let radius, let value):
                healthLayer.remove(at: location, radius: radius, value: value)
            }
        }
    }

}