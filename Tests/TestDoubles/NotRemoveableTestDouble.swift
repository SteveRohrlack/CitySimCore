//
//  NotRemoveableTestDouble.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 06.06.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

@testable import CitySimCoreiOS

struct NotRemoveableTestDouble: Propable, NotRemoveable {
    let origin: (Int, Int)
    let height: Int = 1
    let width: Int = 1
    var content: Int = 1
    let type: TileType = .Propable(.Water)
    
    init(origin: (Int, Int)) {
        self.origin = origin
    }
    
}
