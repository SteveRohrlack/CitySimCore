//
//  MapStatistic.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 17.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/// provides specific statistic types
enum MapStatistic {
    case Landvalue(radius: Int, value: Int)
    case Noise(radius: Int, value: Int)
    case Firehazzard(radius: Int, value: Int)
}