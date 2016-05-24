//
//  Zoneable.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/// basic protocol describing a "Zoneable" Tile
/// a Zoneable is a Tile because it is always "Tileable"
protocol Zoneable: Tileable {
    
    // every zoneable may have a content
    var content: Int? { get set }
}