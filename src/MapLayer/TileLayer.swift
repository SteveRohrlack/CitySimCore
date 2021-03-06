//
//  TileMap.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

/**
 the TileLayer is used to store Tiles
 
 it represents the visible part of the CityMap and is used to render a visual
 representation of it
 
 the TileLayer encapsulates the interaction with the underlying data container
 (Array2DMapping) by providing a high level api to the raw data
*/
public struct TileLayer: Array2DMapping {
    public typealias ValueType = Tileable
    
    /**
     since TileLayer adopts Array2DMapping, the number of rows must be
     available
    */
    let rows: Int
    
    /**
     since TileLayer adopts Array2DMapping, the number of columns must be
     available
     */
    let columns: Int
    
    /// container for values
    public internal(set) var values: [ValueType?]
    
    /**
     initializer
     
     - parameter rows: number of rows
     - parameter columns: number of columns
    */
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        self.values = [ValueType?](count: rows * columns, repeatedValue: nil)
    }
    
    /**
     adds a value
     
     - parameter tile: the value to add
     
     - throws TileableLayerError.TileCantFit if the given tile is out of  the layer bounds
    */
    mutating func add(tile tile: ValueType) throws {
        guard tile.originY >= 0 && tile.originX >= 0 && tile.maxY < rows &&  tile.maxX < columns else {
            throw TileLayerError.TileCantFit
        }
        
        tile.forEachCell { (y: Int, x: Int) in
            self[y, x] = tile
        }
    }
    
    /**
     remove a value
     
     - parameter tile: the value to remove
    */
    mutating func remove(tile tile: ValueType) {
        tile.forEachCell { (y: Int, x: Int) in
            self[y, x] = nil
        }
    }
    
    /**
     retrieve a list of tiles that are located at the given location
     
     - parameter location: the location to search
     
     - returns: list of tiles
    */
    func usedByTilesAt(location location: Locateable) -> [ValueType] {
        var tiles: [ValueType] = []
        
        location.forEachCell { (y: Int, x: Int) in
            guard let tile = self[y, x] else {
                return
            }
            
            let tileAdded = (tiles.contains { (element: ValueType) in
                return element.origin == tile.origin
            })
            
            guard !tileAdded else {
                return
            }
            
            tiles.append(tile)
        }
        
        return tiles
    }
    
    /**
     filters tiles using a supplied filter method
     
     - parameter method: custom filter method
     
     - returns: list of tiles
    */
    func filter(method: (tile: ValueType) -> Bool) -> [ValueType] {
        var tiles: [ValueType] = []
        
        for tile in values {
            guard let tile = tile else {
                continue
            }
            
            let tileAdded = (tiles.contains { (element: ValueType) in
                return element.origin == tile.origin
            })

            guard !tileAdded else {
                continue
            }
            
            guard method(tile: tile) else {
                continue
            }
            
            tiles.append(tile)
        }
        
        return tiles
    }
    
}