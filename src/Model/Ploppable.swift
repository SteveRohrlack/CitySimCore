//
//  Ploppable.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

protocol Ploppable: PloppableTypeable {
    var name: String { get }
    var description: String { get }
    var cost: Int { get }
    var height: Int { get }
    var width: Int { get }
    var effectTypes: [PloppabeleEffectType] { get }
}

extension Ploppable {
    var height: Int {
        return 1
    }
    
    var width: Int {
        return 1
    }
    
    var effectTypes: [PloppabeleEffectType] {
        return []
    }
}