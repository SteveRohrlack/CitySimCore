//
//  CityMapEvents.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 23.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/**
 event names for the CityMap object
*/
public enum CityMapEvent: EventNaming {
    
    /// a tile was added
    case AddTile
    
    /// a tile was removed
    case RemoveTile
}