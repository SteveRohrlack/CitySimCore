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
    
    let rows: Int
    let columns: Int
    var values: [ValueType?]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        self.values = [ValueType?](count: rows * columns, repeatedValue: nil)
    }
    
    mutating func add(at location: Locateable, radius: Int, value: ValueType) {
        let areaIncludingRadius = location + radius
        areaIncludingRadius.forEachCell { (y: Int, x: Int) in
            var newValue = value
            if let currentValue = self[y, x] {
                newValue += currentValue
            }
            self[y, x] = newValue
        }
    }
    
    mutating func remove(at location: Locateable, radius: Int, value: ValueType) throws {
        var errorWhileRemoving: StatisticsLayerError?
        
        let areaIncludingRadius = location + radius
        
        areaIncludingRadius.forEachCell { (y: Int, x: Int) in
            guard let currentValue = self[y, x] else {
                errorWhileRemoving = StatisticsLayerError.CannotRemoveBecauseAlreadyEmpty
                return
            }
            
            var newValue: Int? = currentValue - value
            
            if newValue == 0 {
                newValue = nil
            }
            
            self[y, x] = newValue
        }
        
        if let error = errorWhileRemoving {
            throw error
        }
    }
    
}