//
//  SmallResidentialZone.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 18.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

#if os(iOS)
    @testable import CitySimCoreiOS
#endif

#if os(OSX)
    @testable import CitySimCoreMacOS
#endif

struct SmallResidentialZoneTestDouble: Zoneable {
    let origin: (Int, Int)
    let height: Int = 2
    let width: Int = 2
    var content: Int?
    let type: TileType = .Zoneable(.Residential)
    
    init(origin: (Int, Int)) {
        self.origin = origin
    }
    
}
