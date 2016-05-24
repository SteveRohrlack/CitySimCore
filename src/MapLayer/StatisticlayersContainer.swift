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
struct StatisticlayersContainer {
    
    /// layer for Landvalue
    var landvalueLayer: StatisticsLayer
    
    /// layer for Noise
    var noiseLayer: StatisticsLayer
    
    /**
     constructor
     
     - parameter height: needed to create specific map layers
     - parameter width: needed to create specific map layers
    */
    init(height: Int, width: Int) {
        self.landvalueLayer = StatisticsLayer(rows: height, columns: width)
        self.noiseLayer = StatisticsLayer(rows: height, columns: width)
    }
    
    /**
     add statistic values
     
     decides what layer the given statistics should be added to based on each
     statistics type
     
     - parameter at: location
     - parameter statistical: container of type MapStatistical holding statistics
    */
    mutating func addStatistics(at location: Locateable, statistical: MapStatistical) {
        for statistic in statistical.statistics {
            switch statistic {
            case .Landvalue(let radius, let value):
                landvalueLayer.add(at: location, radius: radius, value: value)
            case .Noise(let radius, let value):
                noiseLayer.add(at: location, radius: radius, value: value)
            default:
                break
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
        for statistic in statistical.statistics {
            switch statistic {
            case .Landvalue(let radius, let value):
                landvalueLayer.remove(at: location, radius: radius, value: value)
            case .Noise(let radius, let value):
                noiseLayer.remove(at: location, radius: radius, value: value)
            default:
                break
            }
        }
    }

}