//
//  Buildable.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 16.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

protocol Buildable: MapStatistical {
    var name: String { get }
    var description: String { get }
    var cost: Int { get }
    var height: Int { get }
    var width: Int { get }
    var type: PloppableType { get }
}

extension Buildable {
    var height: Int {
        return 1
    }
    
    var width: Int {
        return 1
    }
    
    func asPlopp(origin origin: (Int, Int)) -> Plopp {
        let tileType: TileType = .Ploppable(type)
        
        return Plopp(origin: origin, height: height, width: width, type: tileType, name: name, statistics: statistics)
    }
}