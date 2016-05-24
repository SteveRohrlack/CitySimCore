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