//
//  TreeProp.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 19.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

@testable import CitySimCoreiOS

struct TreePropTestDouble: Tileable {
    let origin: (Int, Int)
    let height = 1
    let width = 1
    var content: Int
    let type: TileType = .Propable(.Tree)
    
    init(origin: (Int, Int), content: Int) {
        self.origin = origin
        self.content = content
    }
}