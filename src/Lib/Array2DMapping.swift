//
//  Array2DMapping.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

protocol Array2DMapping {
    associatedtype ValueType
    
    var columns: Int { get }
    var rows: Int { get }
    var values: [ValueType?] { get set }
    
    subscript(row: Int, column: Int) -> ValueType? { get set }
}

extension Array2DMapping {
    subscript(row: Int, column: Int) -> ValueType? {
        get {
            return values[(row * columns) + column]
        }
        set {
            values[(row * columns) + column] = newValue
        }
    }
}