//
//  PloppabeleEffectType.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

enum PloppabeleEffectType {
    case Landvalue(radius: Int, value: Int, accumulates: Bool)
    case Noise(radius: Int, value: Int, accumulates: Bool)
    case Firehazzard(radius: Int, value: Int, accumulates: Bool)
}