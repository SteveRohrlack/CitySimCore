//
//  MapStatistical.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 16.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

protocol MapStatistical {
    var statisticTypes: [MapStatisticType] { get }
}

extension MapStatistical {
    var statisticTypes: [MapStatisticType] {
        return []
    }
}