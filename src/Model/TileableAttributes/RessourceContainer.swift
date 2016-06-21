//
//  RessourceContainer.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 21.06.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/**
 the ConditionContainer encapsulates accessing a list of conditions by
 
 adapting the "Containing" protocol
 */
public struct RessourceContainer: Containing {
    
    /// container for multiple Condition elements
    public var containerContent: [RessourceType] = []
    
    func has(content existingContent: RessourceType) -> Bool {
        return containerContent.contains { $0 >= existingContent }
    }
    
    func get(content content: RessourceType) -> RessourceType? {
        let foundRessourceType = containerContent.filter { $0 >= content }
        
        return foundRessourceType.first
    }
}
