//
//  SmallIndustrialZone.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 19.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

struct SmallIndustrialZone: Zoneable, PlaceNearStreet {
    let origin: (Int, Int)
    let height: Int = 2
    let width: Int = 2
    var content: Int?
    let type: TileType = .Zoneable(.Residential)
    
    init(origin: (Int, Int)) {
        self.origin = origin
    }
}