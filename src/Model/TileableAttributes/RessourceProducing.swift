//
//  RessourceProducing.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 27.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/// an adopting object is seen as producing a fixed amount of one
/// specific ressource
public protocol RessourceProducing {
    
    /// ressource produced
    var ressource: RessourceType { get }

}
