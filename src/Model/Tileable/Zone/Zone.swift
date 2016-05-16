//
//  Zone.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

struct Zone: Zoneable {
    let origin: (Int, Int)
    let height: Int
    let width: Int
    let type: TileType
    var content: Int?
    
    init(origin: (Int, Int), height: Int, width: Int, type: TileType) {
        self.init(origin: origin, height: height, width: width, type: type, content: nil)
    }
    
    init(origin: (Int, Int), height: Int, width: Int, type: TileType, content: Int?) {
        self.origin = origin
        self.height = height
        self.width = width
        self.type = type
        self.content = content
    }
}