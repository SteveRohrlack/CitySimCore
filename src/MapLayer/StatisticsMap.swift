//
//  StatisticsMap.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

struct StatisticsMap: Array2DMapping {
    typealias ValueType = Int
    
    let rows: Int
    let columns: Int
    var values: [ValueType?]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        self.values = [ValueType?](count: rows * columns, repeatedValue: nil)
    }
    
    mutating func addGradient(at location: Locateable, radius: Int, value: ValueType) {
        if location.width == 1 && location.height == 1 {
            var newValue = value
            
            if let currentValue = self[location.origin] {
                newValue += currentValue
            }
            
            self[location.origin] = newValue
            return
        }
        
        let areaIncludingRadius = location + radius
        
        //print(radius, location, areaIncludingRadius)
        
        //ToDo: real gradient!
        areaIncludingRadius.forEachCell {(y: Int, x: Int) in
            var newValue = value
            if let currentValue = self[y, x] {
                newValue += currentValue
            }
            self[y, x] = newValue
        }
    }
}