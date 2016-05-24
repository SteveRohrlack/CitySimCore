//
//  TileableMapError.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/**
 error types for the TileLayer object
 */
enum TileLayerError: ErrorType {
    
    /// a tile does not fit into the map, based on it's dimensions
    case TileCantFit
}
