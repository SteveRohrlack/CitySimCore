//
//  ActorStageable.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 22.07.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/**
 an ActorStageable object is an object that can be used by an Acting object
 as a stage
 
 it also should be a reference type because else, Actors wouldn't make much sense
 */
protocol ActorStageable: class {}