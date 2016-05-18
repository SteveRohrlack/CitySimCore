//
//  WaterProp.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 18.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

struct WaterProp: TileablePropable {
    let origin: (Int, Int)
    let height: Int
    let width: Int
    var content: Int
    let type: TileType = .Propable(.Water)
    
    init(origin: (Int, Int), height: Int, width: Int, content: Int) {
        self.origin = origin
        self.height = height
        self.width = width
        self.content = content
    }
}