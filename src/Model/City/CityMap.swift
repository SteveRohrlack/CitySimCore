///
///  CityMap.swift
///  CitySimCore
///
///  Created by Steve Rohrlack on 13.05.16.
///  Copyright © 2016 Steve Rohrlack. All rights reserved.
///

import Foundation
import GameplayKit

/**
 CityMap encapsules all aspects of working with the simulation's underlying 
 map data.
 
 It provides a high level api to add and remove tiles.
 
 The CityMap consist of multiple layers
 - TileLayer holding all visible tiles
 - StatisticlayersContainer holding all statistical layers
 
 Additionaly, the CityMap contains a Graph representation of Locations that are
 RessourceCyrrying.
 
 CityMap emits events, see CityMapEvent:
 - AddTile: when a tile was successfully added, payload: new tile
 - RemoveTile: when a tile was successfully removed, payload: removed tile
 
*/
public struct CityMap: EventEmitting {

    typealias EventNameType = CityMapEvent

    /// Container holding event subscribers
    var eventSubscribers: [EventNameType: [EventSubscribing]] = [:]
    
    /// height of the map / height of all layers
    public private(set) var height: Int
    
    /// width of the map / width of all layers
    public private(set) var width: Int
    
    /// the tile layer
    public var tileLayer: TileLayer
    
    /// Container holding statistical layers
    public var statisticsLayerContainer: StatisticlayersContainer
    
    /// pathfinding graph
    var graph: GKGridGraph
    
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
        self.graph = GKGridGraph(fromGridStartingAt: vector_int2(0, 0), width: Int32(width), height: Int32(height), diagonalsAllowed: false)
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
        /// check if new tile can fit into the map
        guard newTile.originY >= 0 && newTile.originX >= 0 && newTile.maxY < height &&  newTile.maxX < width else {
            throw CityMapError.TileCantFit
        }

        /// check if desired location is already in use
        let locationUsedByTiles = tileLayer.usedByTilesAt(location: newTile)
        guard locationUsedByTiles.count == 0 else {
            throw CityMapError.CannotAddBecauseNotEmpty
        }
        
        /// check if tile should be placed near a street
        guard newTile is PlaceNearStreet else {
            return
        }
        
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
    
    /**
     private method to add a tile
     
     - parameter tile: the tile to be added
     
     emits the event "AddTile"
     
     throws: TileLayerError if there was a problem
     throws: unspecified error if the event "AddTile" throws
    */
    private mutating func add(tile tile: Tileable) throws {
        try canAdd(tile: tile)
        
        try tileLayer.addTile(tile: tile)
        
        /// adding map statistics for supporting tile
        if let mapStatistical = tile as? MapStatistical {
            statisticsLayerContainer.addStatistics(
                at: tile,
                statistical: mapStatistical
            )
        }
        
        /// adding graph nodes for supporting tile
        if tile is RessourceCarrying {
            graph.addNodes(tile.asNodes())
        }
        
        /// emit event
        try emit(event: CityMapEvent.AddTile, payload: tile)
    }
    
    // MARK: remove, info
    
    /**
     checks if removing all tiles specified by the given location is possible
     
     - parameter location: location
     
     throws CityMapError.TileNotRemoveable if a tile requested to be removed is of type "TileNotRemoveable"
     */
    public func canRemoveAt(location location: Locateable) throws {
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
    public mutating func removeAt(location location: Locateable) throws {
        let tilesToRemove = tileLayer.usedByTilesAt(location: location)
        
        for tile in tilesToRemove {
            if tile is NotRemoveable {
                throw CityMapError.TileNotRemoveable
            }
            
            tileLayer.remove(tile: tile)
            
            /// removing map statistics for supporting tile
            if let mapStatistical = tile as? MapStatistical {
                statisticsLayerContainer.removeStatistics(
                    at: tile,
                    statistical: mapStatistical
                )
            }
            
            /// removing graph nodes for supporting tile
            if tile is RessourceCarrying {
                graph.removeNodes(tile.asNodes())
            }
            
            /// emit event
            try emit(event: CityMapEvent.RemoveTile, payload: tile)
        }
    }
    
    /**
     convenience method to retrieve a list of tiles specified by the given location
     
     - parameter location: location
     
     - returns: list of tiles contained in location
    */
    public func infoAt(location location: Locateable) -> [Tileable] {
        return tileLayer.usedByTilesAt(location: location)
    }
    
    // MARK: zone, plopp, prop
    
    /**
     add a "Zone" (zoneable) to the tile layer
     
     - parameter zone: the zone to add
     
     throws: TileLayerError if there was a problem
    */
    public mutating func zone(zone zone: Zoneable) throws {
        try add(tile: zone)
    }
    
    /**
     add a "Plopp" (ploppable) to the tile layer
     
     - parameter plopp: the ploppable to add
     
     throws: TileLayerError if there was a problem
    */
    public mutating func plopp(plopp plopp: Ploppable) throws {
        try add(tile: plopp)
    }
    
    /**
     add a "Prop" (propable) to the tile layer
     
     - parameter prop: the propable to add
     
     throws: TileLayerError if there was a problem
    */
    public mutating func prop(prop prop: Propable) throws {
        try add(tile: prop)
    }

}
