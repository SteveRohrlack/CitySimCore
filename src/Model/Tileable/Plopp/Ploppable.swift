//
//  Ploppable.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/**
 basic protocol describing a "Ploppable" Tile
 
 a Ploppable is a Tile because it is always "Tileable"
*/
public protocol Ploppable: Tileable {
    
    // every ploppable should have a name
    var name: String { get set }
    
    // every ploppable should have a description
    var description: String { get }
}