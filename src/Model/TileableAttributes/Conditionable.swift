//
//  Conditionable.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 19.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/// a Conditionable object contains a set of conditions
public protocol Conditionable {
    
    /// container for multiple Condition elements
    var conditions: ConditionContainer { get set }
}
