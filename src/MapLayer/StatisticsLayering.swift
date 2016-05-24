//
//  StatisticsLayering.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 17.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/**
 protocol to describe statistical map layers
*/
protocol StatisticsLayering: Array2DMapping {
    
    /**
     add statistical value
     
     - parameter at: where to add
     - parameter radius: radius to apply to location before adding
     - parameter value: what to add
    */
    mutating func add(at location: Locateable, radius: Int, value: ValueType)
    
    /**
     remove statistical value
     
     - parameter at: where to remove
     - parameter radius: radius to apply to location before removing
     - parameter value: what to remove
    */
    mutating func remove(at location: Locateable, radius: Int, value: ValueType) throws
}