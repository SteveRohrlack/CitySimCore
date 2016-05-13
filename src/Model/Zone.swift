//
//  Zone.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

struct Zone: Zoneable {
    let origin: (Int,Int)
    let height: Int
    let width: Int
    let type: TileType
    var content: Int?
}