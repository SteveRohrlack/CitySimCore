//
//  RessourceConsumerTestDouble.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 08.06.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

#if os(iOS)
    @testable import CitySimCoreiOS
#endif

#if os(OSX)
    @testable import CitySimCoreMacOS
#endif

struct RessourceConsumerTestDouble: RessourceConsuming {
    
    let ressources: [RessourceType]
    
}
