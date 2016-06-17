//
//  Acting.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 20.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/**
 an Acting object is an object that can act on the CityMap
 
 "Acting" objects are the main drivers for advancing the simulation
*/
protocol Acting {
    
    /// actor stage
    /// simulation's main data container
    var stage: City { get set }
    
    /**
     Actors gonna act
     
     - parameter tick: the current simulation tick
    */
    mutating func act(tick tick: Int)
    
}

extension Acting {

    /**
     Actors gonna act
     
     - parameter tick: the current simulation tick
     */
    func act(tick tick: Int) {
        
    }

}