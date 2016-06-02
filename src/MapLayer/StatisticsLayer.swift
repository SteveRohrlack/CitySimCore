//
//  StatisticsLayer.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 17.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/**
 the StatisticsLayer is used to store statistical values
 
 each instance represents a certain statistical aspect of the CityMap and 
 is used to render a visual representation of that aspect
 
 the StatisticsLayer encapsulates the interaction with the underlying data 
 container (Array2DMapping) by providing a high level api to the raw data
 */
struct StatisticsLayer: StatisticsLayering {
    typealias ValueType = Int
    
    /**
     since StatisticsLayer adopts Array2DMapping, the number of rows must be
     available
    */
    let rows: Int
    
    /**
     since StatisticsLayer adopts Array2DMapping, the number of columns must be
     available
    */
    let columns: Int
    
    /// container for values
    var values: [ValueType?]
    
    /**
     initializer
     
     - parameter rows: number of rows
     - parameter columns: number of columns
    */
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        self.values = [ValueType?](count: rows * columns, repeatedValue: nil)
    }
    
    /**
     adds a value
     
     - parameter at: where to add
     - parameter radius: radius to apply to location before adding
     - parameter value: what to add
    */
    mutating internal func add(at location: Locateable, radius: Int, value: ValueType) {
        let areaIncludingRadius = location + radius
        areaIncludingRadius.forEachCell { (y: Int, x: Int) in
            var newValue = value
            if let currentValue = self[y, x] {
                newValue += currentValue
            }
            self[y, x] = newValue
        }
    }
    
    /**
     removes a value
     
     - parameter at: where to remove
     - parameter radius: radius to apply to location before removing
     - parameter value: what to remove
     
     - throws: StatisticsLayerError.CannotRemoveBecauseAlreadyEmpty if the location is already empty
    */
    mutating internal func remove(at location: Locateable, radius: Int, value: ValueType) {
        let areaIncludingRadius = location + radius
        
        areaIncludingRadius.forEachCell { (y: Int, x: Int) in
            guard let currentValue = self[y, x] else {
                return
            }
            
            var newValue: Int? = currentValue - value
            
            if newValue == 0 {
                newValue = nil
            }
            
            self[y, x] = newValue
        }
    }
    
}