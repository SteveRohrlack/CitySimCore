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
    
    /**
     This type of tile describes map objects that function as more or less 
     decorative objects.
    */
    case Propable(PropableType)
    
    /**
     Zoneables are tiles that are filled with buildings (growables)
     by the simulation.
    */
    case Zoneable(ZoneableType)
    
    /**
     A ploppable is a predefined tile that can be added to the map. 
     Most ploppables have statistical effects (for example: a park has a 
     positive statistical value associated with the land value layer). 
     A ploppable has a cost for buying it and ongoing cost to 
     cover it’s operation.
    */
    case Ploppable(PloppableType)
}

/**
 operator "==" to allow comparing tile types
 
 - parameter type1: TileType
 - parameter type2: TileType
 
 - returns: comparison result
 */
func == (lhs: TileType, rhs: TileType) -> Bool {
    switch (lhs, rhs) {
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