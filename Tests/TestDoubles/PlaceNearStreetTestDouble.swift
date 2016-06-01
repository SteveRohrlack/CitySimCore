//
//  PlaceNearStreetTestDouble.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 01.06.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

@testable import CitySimCoreiOS

struct PlaceNearStreetTestDouble: Zoneable, PlaceNearStreet {
    let origin: (Int, Int)
    let height: Int = 2
    let width: Int = 2
    var content: Int?
    let type: TileType = .Zoneable(.Residential)
    
    init(origin: (Int, Int)) {
        self.origin = origin
    }
    
}
