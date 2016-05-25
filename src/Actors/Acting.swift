//
//  Acting.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 20.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/// an Acting object is an object that can act on the CityMap
/// Acting objects are the main drivers for advancing the simulation
protocol Acting {
    
    /**
     Actors gonna act
     
     an Actor recieves a "City" object and may manipulate it
     
     - parameter stage: City object
    */
    mutating func act(stage city: City)
    
}
