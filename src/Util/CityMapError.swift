//
//  CityMapError.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

enum CityMapError: ErrorType {
    case TileCantFit
    case UsePropOnly
    case UseZoneableOnly
    case UsePloppableOnly
    case PloppableCannotOverzonePloppable
    case ZoneableCanOnlyOverzoneZoneable
}
