//
//  CityMapError.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/**
 error types for the CityMap object
*/
enum CityMapError: ErrorType {
    
    /// a tile does not fit into the map, based on it's dimensions
    case TileCantFit
    
    /// a tile cannot be added to the CityMap because the requested location
    /// is already taken
    case CannotAddBecauseNotEmpty
    
    /// a tile can not be removed because it states so
    case TileNotRemoveable
    
    /// a tile must be added adjecant to a street plop
    case PlaceNearStreet
}
