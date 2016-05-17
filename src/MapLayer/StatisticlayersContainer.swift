//
//  StatisticlayersContainer.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 17.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

struct StatisticlayersContainer {
    private var height: Int
    private var width: Int
    
    private var landvalueLayer: StatisticsLayer
    private var noiseLayer: StatisticsLayer
    
    init(height: Int, width: Int) {
        self.height = height
        self.width = width
        
        self.landvalueLayer = StatisticsLayer(rows: height, columns: width)
        
        self.noiseLayer = StatisticsLayer(rows: height, columns: width)
    }
    
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