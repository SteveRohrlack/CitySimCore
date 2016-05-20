//
//  Location.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

struct Location: Locateable {
    let origin: (Int, Int)
    let height: Int
    let width: Int
    
    init(origin: (Int, Int), height: Int = 1, width: Int = 1) {
        self.origin = origin
        self.height = height
        self.width = width
    }
}

func + (location: Locateable, radius: Int) -> Locateable {
    let newOrigin = (location.originY - radius, location.originX - radius)
    let newHeight = location.height + (radius * 2)
    let newWidth = location.width + (radius * 2)
    
    return Location(origin: newOrigin, height: newHeight, width: newWidth)
}
