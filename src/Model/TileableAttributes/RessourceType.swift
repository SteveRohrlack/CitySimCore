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
public enum RessourceType {
    
    /// Electricity
    case Electricity(Int?)
    
    /// Water
    case Water(Int?)
    
    /**
     getter for value
     
     - returns: ressource value
    */
    func value() -> Int? {
        switch self {
        case .Electricity(let value):
            return value
        case .Water(let value):
            return value
        }
    }

}

/// RessourceType is Equatable
extension RessourceType: Equatable {
    
}

/**
 operator "==" to allow comparing ressource types types
 
 - parameter lhs: RessourceType
 - parameter rhs: RessourceType
 
 - returns: comparison result
 */
public func == (lhs: RessourceType, rhs: RessourceType) -> Bool {
    switch (lhs, rhs) {
    case (.Electricity(let a), .Electricity(let b)) where a == b:
        return true
    case (.Water(let a), .Water(let b)) where a == b:
        return true
    default:
        return false
    }
}

/**
 operator ">=" to allow comparing ressource types types
 
 - parameter lhs: RessourceType
 - parameter rhs: RessourceType
 
 - returns: comparison result
 */
public func >= (lhs: RessourceType, rhs: RessourceType) -> Bool {
    switch (lhs, rhs) {
    case (.Electricity(let a), .Electricity(let b)) where a >= b:
        return true
    case (.Water(let a), .Water(let b)) where a >= b:
        return true
    default:
        return false
    }
}

/**
 operator "<=" to allow comparing ressource types types
 
 - parameter lhs: RessourceType
 - parameter rhs: RessourceType
 
 - returns: comparison result
 */
public func <= (lhs: RessourceType, rhs: RessourceType) -> Bool {
    switch (lhs, rhs) {
    case (.Electricity(let a), .Electricity(let b)) where a <= b:
        return true
    case (.Water(let a), .Water(let b)) where a <= b:
        return true
    default:
        return false
    }
}