//
//  Condition.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 19.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/// provides specific types of conditions
enum Condition {
    
    /// does not recieve power (electricity)
    case NotPowered
    
    /// does not recieve water
    case NotWatered
    
    /// is on fire
    case OnFire
    
    /// a crimes takes place
    case CrimeScene
    
    /// is abandoned
    case Abandoned
}