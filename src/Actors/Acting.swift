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
    
    mutating func act(on map: CityMap)
    
}
