//
//  ConditionContainer.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 23.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/// the ConditionContainer encapsulates accessing a list of conditions by 
/// adapting the "Containing" protocol
public struct ConditionContainer: Containing {
    
    /// container for multiple Condition elements
    public var containerContent: [Condition] = []
}