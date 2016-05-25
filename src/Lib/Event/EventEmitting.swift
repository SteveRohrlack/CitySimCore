//
//  EventEmitting.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 20.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

protocol EventEmitting {
    associatedtype EventNameType: EventNaming, Hashable
    
    var eventSubscribers: [EventNameType: [EventSubscribing]] { get set }
    
    func emit(event event: EventNameType, payload: Any) throws
    
    mutating func subscribe(subscriber subscriber: EventSubscribing, to event: EventNameType)
    
}

extension EventEmitting {
    
    func emit(event event: EventNameType, payload: Any) throws {
        guard let subscribers = eventSubscribers[event] else {
            return
        }
        
        for subscriber in subscribers {
            try subscriber.recieveEvent(event: event, payload: payload)
        }
    }
    
    mutating func subscribe(subscriber subscriber: EventSubscribing, to event: EventNameType) {
        defer {
            eventSubscribers[event]?.append(subscriber)
        }
        
        guard let _ = eventSubscribers[event] else {
            eventSubscribers[event] = []
            return
        }
    }
    
}
