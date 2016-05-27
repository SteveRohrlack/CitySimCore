//
//  File.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 27.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/// Ressources in the simulation
/// each has a Int parameter, depicting the actual value an adopting object 
/// holds of a specific RessourceType
enum RessourceType {
    
    /// Electricity
    case Electricity(Int)
    
    /// Water
    case Water(Int)
}
