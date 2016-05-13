//
//  StatisticsMap.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

struct StatisticsMap: Array2DMapping {
    typealias ValueType = Statistical
    
    let rows: Int
    let columns: Int
    var values: [ValueType?]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        self.values = [ValueType?](count: rows * columns, repeatedValue: nil)
    }
    
    mutating func addGradient(at location: Locateable, radius: Int, value: ValueType, accumulates: Bool) {
        let areaIncludingRadius = location + radius
        
        print(areaIncludingRadius)
        
        // ToDo
        
        /*areaIncludingRadius.forEachCell {(y: Int, x: Int) in
         print(y, x)
         }*/
    }
}