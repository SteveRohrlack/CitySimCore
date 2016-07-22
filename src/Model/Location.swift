//
//  Location.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation
import GameplayKit

/**
 default implementation for the Locateable protocol
 
 - is needed for operator overloading (see below)
 - should be used by framework users to specify locations
*/
public struct Location: Locateable {
    
    /**
     origin of the location
     this is relative to the used coordinate system
    */
    public let origin: (Int, Int)
    
    /// height of the location, absolute value
    public let height: Int
    
    /// width of the location, absolute value
    public let width: Int
    
    /// initializer
    init(origin: (Int, Int), height: Int = 1, width: Int = 1) {
        self.origin = origin
        self.height = height
        self.width = width
    }

}

/**
 operator "+" to allow adding a specified radius to a Locateable
 
 - parameter location: the location the radius should be added to
 - parameter radius: the radius to be added
 
 - returns: new Location instance that covers the given location including the given radius
*/
public func + (location: Locateable, radius: Int) -> Locateable {
    var newOrigin = (location.originY - radius, location.originX - radius)
    
    if newOrigin.0 < 0 {
       newOrigin.0 = 0
    }
    
    if newOrigin.1 < 0 {
        newOrigin.1 = 0
    }
    
    let newHeight = location.height + (radius * 2)
    let newWidth = location.width + (radius * 2)
    
    return Location(origin: newOrigin, height: newHeight, width: newWidth)
}
