//
//  MapStatistic.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 17.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/**
 provides specific statistic types
 
 each type consists of:
 
 - radius: Int
 - value: Int
*/
enum MapStatistic {
    
    /// regards the Landvalue statistic layer
    case Landvalue(radius: Int, value: Int)
    
    /// regards the Noise statistic layer
    case Noise(radius: Int, value: Int)
    
    /// regards the Firehazzard statistic layer
    case Firehazzard(radius: Int, value: Int)
}

extension MapStatistic: Equatable {
    
}

func == (lhs: MapStatistic, rhs: MapStatistic) -> Bool {
    switch (lhs, rhs) {
    case (.Landvalue(let a1, let b1), .Landvalue(let a2, let b2)) where a1 == a2 && b1 == b2:
        return true
    case (.Noise(let a1, let b1), .Landvalue(let a2, let b2)) where a1 == a2 && b1 == b2:
        return true
    case (.Firehazzard(let a1, let b1), .Landvalue(let a2, let b2)) where a1 == a2 && b1 == b2:
        return true
    default:
        return false
    }
}