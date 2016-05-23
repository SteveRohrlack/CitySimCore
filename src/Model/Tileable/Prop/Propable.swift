//
//  Propable.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 16.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/// basic protocol describing a "Propable" Tile
/// a Propable is a Tile because it is always "Tileable"
protocol Propable: Tileable {
    var content: Int { get }
}