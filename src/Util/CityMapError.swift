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
    case TileCantFit
    case CannotAddBecauseNotEmpty
    case TileNotRemoveable
    case PlaceNearStreet
}
