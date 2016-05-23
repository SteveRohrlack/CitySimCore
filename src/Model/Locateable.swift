//
//  Locateable.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/**
 the Locateable protocol describes a location on a 2D map
 
 it proves several helpers for getting and calculating often needed values
*/
protocol Locateable {
    var origin: (Int, Int) { get }
    var height: Int { get }
    var width: Int { get }
    var maxY: Int { get }
    var maxX: Int { get }
    var originY: Int { get }
    var originX: Int { get }
    var forEachCell: ((((Int, Int) -> Void)) -> Void) { get }
}

extension Locateable {
    /// since "origin" is a tuple, accessing the tuple's
    /// content is more convenient and readable using .originY instead of 
    /// .origin.0
    var originY: Int {
        return origin.0
    }

    /// since "origin" is a tuple, accessing the tuple's
    /// content is more convenient and readable using .originX instead of
    /// .origin.1
    var originX: Int {
        return origin.1
    }
    
    /// calculates Y coordinate based on the location's origin and it's height
    var maxY: Int {
        return origin.0 - 1 + height
    }
    
    /// calculates X coordinate based on the location's origin and it's width
    var maxX: Int {
        return origin.1 - 1 + width
    }
    
    /**
     return a function to call with another function as parameter to recieve 
     y, x coordinates for each cell in the location
     
     - returns: function
    */
    var forEachCell: ((((Int, Int) -> Void)) -> Void) {

        func forEach(callback: ((y: Int, x: Int) -> Void)) -> Void {
            for y in (originY...maxY) {
                for x in (originX...maxX) {
                    callback(y: y, x: x)
                }
            }
        }
        
        return forEach
    }
}
