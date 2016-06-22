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
    func add(location location: Locateable) {
        let nodes = location.nodes
        
        for node in nodes {
            connectNodeToAdjacentNodes(node)
        }
    }
    
    /**
     removes Locateable from graph
     
     - parameter location: the location to remove
     */
    func remove(location location: Locateable) {
        removeNodes(location.nodes)
    }
    
    /**
     gets node at grid position by Locateable
     uses origin of Locateable
     
     - parameter location: the location to use
     
     - returns: GKGridGraphNode optional
    */
    func nodeAtGridPosition(location location: Locateable) -> GKGridGraphNode? {
        guard let firstNode = location.nodes.first else {
            return nil
        }
        
        return nodeAtGridPosition(firstNode.gridPosition)
    }
    
}