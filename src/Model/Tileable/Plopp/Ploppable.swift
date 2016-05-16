//
//  Ploppable.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

protocol Ploppable: Tileable, MapStatistical {
    var name: String { get set }
}