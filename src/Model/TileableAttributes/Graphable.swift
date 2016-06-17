//
//  Graphable.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 17.06.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation
import GameplayKit

/// adopting this protocol makes an object present in the pathfinding
/// if something is graphable, it also needs to be Locateable
public protocol Graphable: Locateable {
    
    /**
     converts Locateable to GraphNode
     
     - returns: GraphNode representation of location
    */
    func asNode() -> GKGridGraphNode
}

extension Graphable {

    /**
     converts Locateable to GraphNode
     
     - returns: GraphNode representation of location
     */
    func asNode() -> GKGridGraphNode {
        return GKGridGraphNode(gridPosition: vector_int2(Int32(originY), Int32(originX)))
    }
    
}
