//
//  TileType.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/// provides a set of basic tile types
/// TileType is also "Equatable"
enum TileType: Equatable {
    case Propable(PropType)
    case Zoneable(ZoneableType)
    case Ploppable(PloppableType)
}

/**
 operator "==" to allow comparing tile types
 
 - parameter type1: TileType
 - parameter type2: TileType
 
 -returns: comparison result
 */
func == (type1: TileType, type2: TileType) -> Bool {
    switch (type1, type2) {
    case (.Propable(let a), .Propable(let b)) where a == b:
        return true
    case (.Zoneable(let a), .Zoneable(let b)) where a == b:
        return true
    case (.Ploppable(let a), .Ploppable(let b)) where a == b:
        return true
    default:
        return false
    }
}