//
//  GKGridGraph.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 21.06.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation
import GameplayKit

/**
 GKGridGraph extension to offer convenience methods for working with Locateables
*/
extension GKGridGraph {
    
    /**
     adds Locateable to graph
     
     - parameter location: the location to add
    */
    func addLocation(location location: Locateable) {
        addNodes(location.nodes)
    }
    
    /**
     removes Locateable from graph
     
     - parameter location: the location to remove
     */
    func removeLocation(location location: Locateable) {
        removeNodes(location.nodes)
    }
    
}