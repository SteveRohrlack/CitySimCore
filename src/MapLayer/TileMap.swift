//
//  TileMap.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

struct TileMap: Array2DMapping {
    typealias ValueType = Tileable
    
    let rows: Int
    let columns: Int
    var values: [ValueType?]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        self.values = [ValueType?](count: rows * columns, repeatedValue: nil)
    }
    
    mutating func addTile(tile tile: ValueType) throws {
        guard tile.originY >= 0 && tile.originX >= 0 && tile.maxY < rows &&  tile.maxX < columns else {
            throw TileableMapError.TileCantFit
        }
        
        tile.forEachCell {(y: Int, x: Int) in
            self[y,x] = tile
        }
    }
    
    mutating func remove(tile tile: ValueType) {
        tile.forEachCell {(y: Int, x: Int) in
            self[y, x] = nil
        }
    }
    
    func usedByTilesAt(location location: Locateable) -> [ValueType] {
        var tiles: [ValueType] = []
        
        location.forEachCell {(y: Int, x: Int) in
            guard let tile = self[y,x] else {
                return
            }
            
            if !(tiles.contains {(element: ValueType) in
                element.type == tile.type
                }) {
                tiles.append(tile)
            }
        }
        
        return tiles
    }
}