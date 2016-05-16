//
//  Statistical.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

enum MapStatisticType {
    case Landvalue(radius: Int, value: Int)
    case Noise(radius: Int, value: Int)
    case Firehazzard(radius: Int, value: Int)
}