///
///  CityMap.swift
///  CitySimCore
///
///  Created by Steve Rohrlack on 13.05.16.
///  Copyright © 2016 Steve Rohrlack. All rights reserved.
///

import Foundation

class CityMap: EventEmitting {

    typealias EventNameType = CityMapEvents
    
    internal var height: Int
    internal var width: Int
    internal var eventSubscribers: [EventNameType: [EventSubscribing]] = [:]
    var tileLayer: TileLayer
    var statisticsLayerContainer: StatisticlayersContainer
    
    init(height: Int, width: Int) {
        self.width = width
        self.height = height
        self.tileLayer = TileLayer(rows: height, columns: width)
        self.statisticsLayerContainer = StatisticlayersContainer(height: height, width: width)
    }
    
    // MARK: add, remove
    
    func canAdd(tile newTile: Tileable) throws {
        guard newTile.originY >= 0 && newTile.originX >= 0 && newTile.maxY < height &&  newTile.maxX < width else {
            throw CityMapError.TileCantFit
        }
        
        let locationUsedByTiles = tileLayer.usedByTilesAt(location: newTile)
        
        guard locationUsedByTiles.count == 0 else {
            throw CityMapError.CannotAddBecauseNotEmpty
        }
        
        if newTile is PlaceNearStreet {
            let check = newTile + 1
            
            let checkLocationUsedByTiles = tileLayer.usedByTilesAt(location: check)
            
            let adjecantStreet = checkLocationUsedByTiles.contains { (tile: Tileable) in
                guard case .Ploppable(let ploppType) = tile.type where ploppType == .Street else {
                    return false
                }
                return true
            }
            
            if !adjecantStreet {
                throw CityMapError.PlaceNearStreet
            }
        }
    }
    
    private func add(tile tile: Tileable) throws {
        try canAdd(tile: tile)
        
        try tileLayer.addTile(tile: tile)
        
        try emit(event: CityMapEvents.AddTile, payload: tile)
    }
    
    // MARK: remove, info
    
    func removeAt(location location: Locateable) throws {
        let tilesToRemove = tileLayer.usedByTilesAt(location: location)
        
        for tile in tilesToRemove {
            if tile is NotRemoveable {
                throw CityMapError.TileNotRemoveable
            }
            
            if tile is MapStatistical {
                try statisticsLayerContainer.removeStatistics(
                    at: tile,
                    statistical: tile as! MapStatistical // tailor:disable
                )
            }
            
            tileLayer.remove(tile: tile)
            
            try emit(event: CityMapEvents.RemoveTile, payload: tile)
        }
    }
    
    func infoAt(location location: Locateable) -> [Tileable] {
        return tileLayer.usedByTilesAt(location: location)
    }
    
    // MARK: zone, plopp, prop
    
    func zone(zone zone: Zoneable) throws {
        try add(tile: zone)
    }
    
    func plopp(plopp plopp: Ploppable) throws {
        try add(tile: plopp)
        
        if plopp is MapStatistical {
            statisticsLayerContainer.addStatistics(
                at: plopp,
                statistical: plopp as! MapStatistical // tailor:disable
            )
        }
    }
    
    func prop(prop prop: Propable) throws {
        try add(tile: prop)
    }

}
