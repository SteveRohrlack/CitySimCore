//
//  Locateable.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation
import GameplayKit

/**
 the Locateable protocol describes a location on a 2D map
 
 it provides several helpers for getting and calculating often needed values
 
 - y = height
 - x = width
*/
public protocol Locateable {
    
    /// origin of the location
    /// this is relative to the used coordinate system
    var origin: (Int, Int) { get }
    
    /// height of the location, absolute value
    var height: Int { get }
    
    /// width of the location, absolute value
    var width: Int { get }
    
    /// relative maximum Y value
    var maxY: Int { get }
    
    /// relative maximum X value
    var maxX: Int { get }
    
    /// origin's Y value
    var originY: Int { get }
    
    /// origin's X value
    var originX: Int { get }
    
    /// helper to iterate over each cell
    var forEachCell: ((((Int, Int) -> Void)) -> Void) { get }
    
    /// representation as GKGridGraphNodes
    var nodes: [GKGridGraphNode] { get }
}

extension Locateable {
    /// since "origin" is a tuple, accessing the tuple's
    /// content is more convenient and readable using .originY instead of 
    /// .origin.0
    public var originY: Int {
        return origin.0
    }

    /// since "origin" is a tuple, accessing the tuple's
    /// content is more convenient and readable using .originX instead of
    /// .origin.1
    public var originX: Int {
        return origin.1
    }
    
    /// calculates Y coordinate based on the location's origin and it's height
    public var maxY: Int {
        return origin.0 - 1 + height
    }
    
    /// calculates X coordinate based on the location's origin and it's width
    public var maxX: Int {
        return origin.1 - 1 + width
    }
    
    /**
     return a function to call with another function as parameter to recieve 
     y, x coordinates for each cell in the location
     
     - returns: function
    */
    public var forEachCell: ((((Int, Int) -> Void)) -> Void) {

        func forEach(callback: ((y: Int, x: Int) -> Void)) -> Void {
            for y in (originY...maxY) {
                for x in (originX...maxX) {
                    callback(y: y, x: x)
                }
            }
        }
        
        return forEach
    }
    
    /// representation as GKGridGraphNodes
    public var nodes: [GKGridGraphNode] {
        var nodes: [GKGridGraphNode] = []
        
        forEachCell { (y: Int, x: Int) in
            nodes.append(GKGridGraphNode(gridPosition: vector_int2(Int32(y), Int32(x))))
        }
        
        return nodes
    }

}

/**
 operator "==" to allow comparing Locations
 
 - parameter lhs: Locateable
 - parameter rhs: Locateable
 
 - returns: Bool
 */
public func == (lhs: Locateable, rhs: Locateable) -> Bool {
    return lhs.origin == rhs.origin && lhs.height == rhs.height && lhs.width == rhs.width
}