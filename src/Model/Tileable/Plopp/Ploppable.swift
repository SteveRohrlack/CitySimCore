//
//  Ploppable.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

protocol Ploppable: Tileable {
    var name: String { get set }
    var description: String { get }
    var cost: Int { get }
}