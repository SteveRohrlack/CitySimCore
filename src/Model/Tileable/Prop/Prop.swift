//
//  Prop.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 16.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

struct Prop: Propable {
    let origin: (Int, Int)
    let height: Int
    let width: Int
    let type: TileType
    let content: Int
}