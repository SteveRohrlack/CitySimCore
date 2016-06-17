//
//  Tileable.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/**
 basic protocol describing a "Tile"
 Tiles are always "Locateable"
*/
public protocol Tileable: Locateable {
    var type: TileType { get }
}