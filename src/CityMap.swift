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
    
    private func updateStatisticsLayers(ploppable plopp: Ploppable) {
        for statisticType in plopp.statisticTypes {
            switch statisticType {
            case .Landvalue(let radius, let value):
                landvalueLayer.addGradient(at: plopp, radius: radius, value: value)
            case .Noise(let radius, let value):
                noiseLayer.addGradient(at: plopp, radius: radius, value: value)
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
            if tile is MapStatisticType {
                
            }
            
            tileLayer.remove(tile: tile)
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
    
    func plopp(plopp plopp: Ploppable) throws {
        try add(tile: plopp)
        
        updateStatisticsLayers(ploppable: plopp)
    }
    
    func prop(prop prop: Prop) throws {
        try add(tile: prop)
    }
}
