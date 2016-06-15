//
//  ZoneTestDouble.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 15.06.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

#if os(iOS)
    @testable import CitySimCoreiOS
#endif

#if os(OSX)
    @testable import CitySimCoreMacOS
#endif

struct ZoneTestDouble: Zoneable {
    let origin: (Int, Int)
    let height: Int = 2
    let width: Int = 2
    var content: Int?
    let type: TileType = .Zoneable(.Residential)
    
    init(origin: (Int, Int)) {
        self.origin = origin
    }
    
}
