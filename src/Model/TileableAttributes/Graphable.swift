//
//  Graphable.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 17.06.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation
import GameplayKit

/**
 adopting this protocol makes an object present in the pathfinding graph
*/
public protocol Graphable {
}

extension Locateable {
    /**
     converts Locateable to GraphNodes
     
     - returns: GraphNode representation of location
     */
    func asNodes() -> [GKGridGraphNode] {
        var nodes: [GKGridGraphNode] = []
        
        forEachCell { (y: Int, x: Int) in
            nodes.append(GKGridGraphNode(gridPosition: vector_int2(Int32(y), Int32(x))))
        }
        
        return nodes
    }

}