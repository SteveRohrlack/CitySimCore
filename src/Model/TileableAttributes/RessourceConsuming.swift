//
//  RessourceConsuming.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 27.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/// an adopting object may consume specific amounts of one or more ressources 
protocol RessourceConsuming {
    
    /// list of ressources consumed
    var ressources: [RessourceType] { get }
    
    func consumes(ressource ressource: RessourceType) -> Bool
}

extension RessourceConsuming {
    
    /**
     
    */
    func consumes(ressource ressourceSearch: RessourceType) -> Bool {
        return ressources.contains { (ressource) in
            ressource == ressourceSearch
        }
    }
    
}
