//
//  Ressources.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 31.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/// handles city ressources
public struct Ressources {
    
    /// demand for electricity, sum of all electricity consumer's ressource value
    public var electricityDemand: Int
    
    /// supply of electricity, sum of all electricity producers
    public var electricitySupply: Int
    
    /// states if the electricity "flow" needs to be recalculated
    public var electricityNeedsRecalculation: Bool
    
}