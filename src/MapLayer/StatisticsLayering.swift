//
//  StatisticsLayering.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 17.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

protocol StatisticsLayering: Array2DMapping {
    mutating func add(at location: Locateable, radius: Int, value: ValueType)
    
    mutating func remove(at location: Locateable, radius: Int, value: ValueType) throws
}