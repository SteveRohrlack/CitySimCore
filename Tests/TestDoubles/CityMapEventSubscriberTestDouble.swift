//
//  CityMapEventSubscriberTestDouble.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 09.06.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

#if os(iOS)
    @testable import CitySimCoreiOS
#endif

#if os(OSX)
    @testable import CitySimCoreMacOS
#endif

class CityMapEventSubscriberTestDouble: EventSubscribing {
    
    var eventHandler: (event: EventNaming, payload: Any) -> Void
    
    init(eventHandler: (EventNaming,Any) -> Void) {
        self.eventHandler = eventHandler
    }
    
    func recieveEvent(event event: EventNaming, payload: Any) throws {
        eventHandler(event: event, payload: payload)
    }
    
}