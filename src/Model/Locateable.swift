//
//  Locateable.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

protocol Locateable {
    var origin: (Int,Int) { get }
    var height: Int { get }
    var width: Int { get }
    var maxY: Int { get }
    var maxX: Int { get }
    var originY: Int { get }
    var originX: Int { get }
    var forEachCell: ((((Int, Int) -> Void)) -> Void) { get }
}

extension Locateable {
    var originY: Int {
        return origin.0
    }
    
    var originX: Int {
        return origin.1
    }
    
    var maxY: Int {
        return origin.0 - 1 + height
    }
    
    var maxX: Int {
        return origin.1 - 1 + width
    }
    
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