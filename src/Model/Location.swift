//
//  Location.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/**
 default implementation for the Locateable protocol
 
 - is needed for operator overloading (see below)
 - should be used by framework users to specify locations
*/
struct Location: Locateable {
    
    /// origin of the location
    /// this is relative to the used coordinate system
    let origin: (Int, Int)
    
    /// height of the location, absolute value
    let height: Int
    
    /// width of the location, absolute value
    let width: Int
    
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
func + (location: Locateable, radius: Int) -> Locateable {
    let newOrigin = (location.originY - radius, location.originX - radius)
    let newHeight = location.height + (radius * 2)
    let newWidth = location.width + (radius * 2)
    
    return Location(origin: newOrigin, height: newHeight, width: newWidth)
}

/**
 operator "==" to allow comparing Locations
 
 - parameter lhs: location
 - parameter rhs: location
 
 - returns: Bool
 */
func == (lhs: Location, rhs: Location) -> Bool {
    return lhs.origin == rhs.origin && lhs.height == rhs.height && lhs.width == rhs.width
}
