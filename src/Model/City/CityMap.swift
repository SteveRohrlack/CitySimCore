///
///  CityMap.swift
///  CitySimCore
///
///  Created by Steve Rohrlack on 13.05.16.
///  Copyright © 2016 Steve Rohrlack. All rights reserved.
///

import Foundation

/**
 CityMap encapsules all aspects of working with the simulation's underlying 
 map data.
 
 It provides a high level api to add and remove tiles.
 
 The CityMap consist of multiple layers
 - TileLayer holding all visible tiles
 - StatisticlayersContainer holding all statistical layers
 
 CityMap emits different events
*/
struct CityMap: EventEmitting {

    typealias EventNameType = CityMapEvents

    /// Container holding event subscribers
    internal var eventSubscribers: [EventNameType: [EventSubscribing]] = [:]
    
    /// height of the map / height of all layers
    internal var height: Int
    
    /// width of the map / width of all layers
    internal var width: Int
    
    /// the tile layer
    var tileLayer: TileLayer
    
    /// Container holding statistical layers
    var statisticsLayerContainer: StatisticlayersContainer
    
    /**
     Constructur
     
     - parameter height: height of the map / height of all layers
     - parameter width: width of the map / width of all layers
    */
    init(height: Int, width: Int) {
        self.width = width
        self.height = height
        self.tileLayer = TileLayer(rows: height, columns: width)
        self.statisticsLayerContainer = StatisticlayersContainer(height: height, width: width)
    }
    
    // MARK: add, remove
    
    /**
     convenience method to check if a tile can be added to the tile layer
     
     also checks dependencies for tiles to be added: must be placed near road
     
     - parameter tile: tile to be added
     
     throws: CityMapError.TileCantFit if the new tile doesn't fit into the tile layer
     throws: CityMapError.CannotAddBecauseNotEmpty if the desired tile location is already in use
     throws: CityMapError.PlaceNearStreet if the tile should be placed adjecant to a street ploppable and isn't
    */
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
    
    /**
     internal method to add a tile
     
     - parameter tile: the tile to be added
     
     emits the event "AddTile"
     
     throws: TileLayerError if there was a problem
     throws: unspecified error if the event "AddTile" throws
    */
    internal mutating func add(tile tile: Tileable) throws {
        try canAdd(tile: tile)
        
        try tileLayer.addTile(tile: tile)
        
        try emit(event: CityMapEvents.AddTile, payload: tile)
    }
    
    // MARK: remove, info
    
    /**
     checks if removing all tiles specified by the given location is possible
     
     - parameter location: location
     
     throws CityMapError.TileNotRemoveable if a tile requested to be removed is of type "TileNotRemoveable"
     */
    func canRemoveAt(location location: Locateable) throws {
        let tilesToRemove = tileLayer.usedByTilesAt(location: location)
        
        for tile in tilesToRemove {
            if tile is NotRemoveable {
                throw CityMapError.TileNotRemoveable
            }
        }
    }
    
    /**
     removes all tiles specified by the given location
     
     - parameter location: location
     
     emits the event "RemoveTile"
     
     throws CityMapError.TileNotRemoveable if a tile requested to be removed is of type "TileNotRemoveable"
     throws: unspecified error if the event "RemoveTile" throws
    */
    mutating func removeAt(location location: Locateable) throws {
        let tilesToRemove = tileLayer.usedByTilesAt(location: location)
        
        for tile in tilesToRemove {
            if tile is NotRemoveable {
                throw CityMapError.TileNotRemoveable
            }
            
            if tile is MapStatistical {
                statisticsLayerContainer.removeStatistics(
                    at: tile,
                    statistical: tile as! MapStatistical // tailor:disable
                )
            }
            
            tileLayer.remove(tile: tile)
            
            try emit(event: CityMapEvents.RemoveTile, payload: tile)
        }
    }
    
    /**
     convenience method to retrieve a list of tiles specified by the given location
     
     - parameter location: location
     
     - returns: list of tiles contained in location
    */
    func infoAt(location location: Locateable) -> [Tileable] {
        return tileLayer.usedByTilesAt(location: location)
    }
    
    // MARK: zone, plopp, prop
    
    /**
     add a "Zone" (zoneable) to the tile layer
     
     - parameter zone: the zone to add
     
     throws: TileLayerError if there was a problem
    */
    mutating func zone(zone zone: Zoneable) throws {
        try add(tile: zone)
    }
    
    /**
     add a "Plopp" (ploppable) to the tile layer
     
     - parameter plopp: the ploppable to add
     
     throws: TileLayerError if there was a problem
    */
    mutating func plopp(plopp plopp: Ploppable) throws {
        try add(tile: plopp)
        
        if plopp is MapStatistical {
            statisticsLayerContainer.addStatistics(
                at: plopp,
                statistical: plopp as! MapStatistical // tailor:disable
            )
        }
    }
    
    /**
     add a "Prop" (propable) to the tile layer
     
     - parameter prop: the propable to add
     
     throws: TileLayerError if there was a problem
    */
    mutating func prop(prop prop: Propable) throws {
        try add(tile: prop)
    }

}
