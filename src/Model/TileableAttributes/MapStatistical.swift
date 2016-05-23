//
//  MapStatistical.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 16.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/// a MapStatistical object contains a set of statistics
protocol MapStatistical {
    var statistics: [MapStatistic] { get }
}