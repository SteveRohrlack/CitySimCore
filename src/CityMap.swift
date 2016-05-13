//
//  CityMap.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 13.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

class CityMap {
    private var height: Int
    private var width: Int
    private var tileLayer: TileMap
    private var landvalueLayer: StatisticsMap
    private var noiseLayer: StatisticsMap
    
    init(height: Int, width: Int) {
        self.width = width
        self.height = height
        self.tileLayer = TileMap(rows: height, columns: width)
        self.landvalueLayer = StatisticsMap(rows: height, columns: width)
        self.noiseLayer = StatisticsMap(rows: height, columns: width)
    }
    
    private func updateStatisticsLayers(ploppable plopp: Ploppable, at location: Locateable) {
        for effectType in plopp.effectTypes {
            switch effectType {
            case .Landvalue(let radius, let value, let accumulates):
                landvalueLayer.addGradient(at: location, radius: radius, value: value, accumulates: accumulates)
                //case .Noise(let radius, let value):
                //noiseLayer.addGradient(at: location, radius: radius, value: value)
                break
            default:
                break
            }
        }
    }
    
    // MARK: add, remove
    
    func canAdd(tile newTile: Tileable) throws {
        guard newTile.originY >= 0 && newTile.originX >= 0 && newTile.maxY < height &&  newTile.maxX < width else {
            throw CityMapError.TileCantFit
        }
        
        let locationUsedByTiles = tileLayer.usedByTilesAt(location: newTile)
        
        guard locationUsedByTiles.count > 0 else {
            return
        }
        
        //overzoning
        var overzoningError: CityMapError?
        
        let _ = locationUsedByTiles.contains({ (element: Tileable) in
            //overzoning anything on water
            if case .Prop(let proptype) = element.type where proptype == .Water {
                overzoningError = CityMapError.PloppableCannotOverzonePloppable
                return true
            }
            
            //overzoning ploppables on ploppables
            if case .Ploppable = newTile.type {
                if case .Ploppable = element.type {
                    overzoningError = .PloppableCannotOverzonePloppable
                    return true
                }
            }
            
            //overzoning zoneable on anything
            if case .Zoneable = newTile.type {
                switch element.type {
                case .Ploppable:
                    overzoningError = .ZoneableCanOnlyOverzoneZoneable
                    return true
                case .Prop:
                    overzoningError = .ZoneableCanOnlyOverzoneZoneable
                    return true
                default:
                    break;
                }
            }
            
            return false
        })
        
        if let error = overzoningError {
            throw error
        }
    }
    
    private func add(tile tile: Tileable) throws {
        try canAdd(tile: tile)
        
        do {
            try tileLayer.addTile(tile: tile)
        } catch TileableMapError.TileCantFit {
            // Fatal error
        } catch {}
    }
    
    // MARK: remove, info
    
    func removeAt(location location: Locateable) {
        let tilesToRemove = tileLayer.usedByTilesAt(location: location)
        
        for tile in tilesToRemove {
            //TODO
        }
    }
    
    func infoAt(location location: Locateable) -> [Tileable] {
        return tileLayer.usedByTilesAt(location: location)
    }
    
    // MARK: zone, plopp, prop
    
    func zone(zone zone: Zoneable) throws {
        guard case .Zoneable = zone.type else {
            throw CityMapError.UseZoneableOnly
        }
        
        try add(tile: zone as Tileable)
    }
    
    func plopp(ploppable plopp: Ploppable, origin: (Int,Int)) throws {
        let tile = Tile(origin: origin, height: plopp.height, width: plopp.width, type: .Ploppable(plopp.type))
        
        try add(tile: tile)
        
        updateStatisticsLayers(ploppable: plopp, at: tile)
    }
    
    func prop(tile tile: Tile) throws {
        guard case .Prop = tile.type else {
            throw CityMapError.UsePropOnly
        }
        
        try add(tile: tile)
    }
}
