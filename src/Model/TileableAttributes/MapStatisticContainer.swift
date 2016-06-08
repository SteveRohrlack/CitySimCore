//
//  MapStatisticalContainer.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 25.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/// the MapStatisticContainer encapsulates accessing a list of MapStatistics by
/// adapting the "Containing" protocol
public struct MapStatisticContainer: Containing {
    
    /// container for multiple MapStatistic elements
    public var containerContent: [MapStatistic] = []
    
    init(mapStatistics: MapStatistic...) {
        containerContent = mapStatistics
    }
}
