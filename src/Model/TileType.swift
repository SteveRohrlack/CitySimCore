//
//  TileType.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

enum TileType: Equatable {
    case Prop(PropType)
    case Zoneable(ZoneableType)
    case Ploppable(PloppableType)
}

func == (type1: TileType, type2: TileType) -> Bool {
    switch (type1, type2) {
    case (.Prop(let a), .Prop(let b)) where a == b:
        return true
    case (.Zoneable(let a), .Zoneable(let b)) where a == b:
        return true
    case (.Ploppable(let a), .Ploppable(let b)) where a == b:
        return true
    default:
        return false
    }
}