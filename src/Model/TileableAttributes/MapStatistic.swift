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
public enum MapStatistic {
    
    /// regards the Landvalue statistic layer
    case Landvalue(radius: Int, value: Int)
    
    /// regards the Noise statistic layer
    case Noise(radius: Int, value: Int)
    
    /// regards the Firesafety statistic layer
    case Firesafety(radius: Int, value: Int)
    
    /// regards the Crime statistic layer
    case Crime(radius: Int, value: Int)
    
    /// regards the Health statistic layer
    case Health(radius: Int, value: Int)
}

/// MapStatistic is Equatable
extension MapStatistic: Equatable {
    
}

/**
 operator "==" to allow comparing MapStatistics
 
 - parameter lhs: MapStatistic
 - parameter rhs: MapStatistic
 
 - returns: comparison result
 */
public func == (lhs: MapStatistic, rhs: MapStatistic) -> Bool {
    switch (lhs, rhs) {
    case (.Landvalue(let a1, let b1), .Landvalue(let a2, let b2)) where a1 == a2 && b1 == b2:
        return true
    case (.Noise(let a1, let b1), .Landvalue(let a2, let b2)) where a1 == a2 && b1 == b2:
        return true
    case (.Firesafety(let a1, let b1), .Landvalue(let a2, let b2)) where a1 == a2 && b1 == b2:
        return true
    case (.Crime(let a1, let b1), .Landvalue(let a2, let b2)) where a1 == a2 && b1 == b2:
        return true
    case (.Health(let a1, let b1), .Landvalue(let a2, let b2)) where a1 == a2 && b1 == b2:
        return true
    default:
        return false
    }
}