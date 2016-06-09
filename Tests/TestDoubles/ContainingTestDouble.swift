//
//  ContainingTestDouble.swift
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

struct ContainingTestDouble: Containing {
    var containerContent: [String] = []
}