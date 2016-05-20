//
//  Conditionable.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 19.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

protocol Conditionable: Containing {
    var containerContent: [Condition] { get set }
}
