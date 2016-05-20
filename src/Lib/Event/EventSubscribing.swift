//
//  EventSubscribing.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 20.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

protocol EventSubscribing {
    var eventSubscriberId: String { get }
    
    func recieveEvent(event event: EventNaming, payload: Any) throws
}