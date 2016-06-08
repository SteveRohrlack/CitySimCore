//
//  RessourceConsuming.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 27.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/// an adopting object may consume specific amounts of one or more ressources 
public protocol RessourceConsuming {
    
    /// list of ressources consumed
    var ressources: [RessourceType] { get }
    
    /**
     checks wether the given RessourceType is consumed, ignoring the value
     
     - parameter ressource: the RessourceType to search for
     
     - returns: Bool
    */
    func consumes(ressource ressource: RessourceType) -> Bool
}

extension RessourceConsuming {
    
    /**
     checks wether the given RessourceType is consumed, ignoring the value
     
     - parameter ressource: the RessourceType to search for
     
     - returns: Bool
     */
    func consumes(ressource ressource: RessourceType) -> Bool {
        return ressources.contains { (consumedRessource) in
            return consumedRessource >= ressource
        }
    }
    
}
