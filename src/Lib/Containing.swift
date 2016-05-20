//
//  Containing.swift
//  CitySimCore
//
//  Created by Steve Rohrlack on 20.05.16.
//  Copyright © 2016 Steve Rohrlack. All rights reserved.
//

import Foundation

protocol Containing {
    associatedtype ContentType: Equatable
    
    var containerContent: [ContentType] { get set }
    
    mutating func add(content newContent: ContentType)
    mutating func remove(content existingContent: ContentType)
    func has(content existingContent: ContentType) -> Bool
    
}

extension Containing {
    mutating func add(content newContent: ContentType) {
        guard !has(content: newContent) else {
            return
        }
        
        containerContent.append(newContent)
    }
    
    mutating func remove(content existingContent: ContentType) {
        guard has(content: existingContent) else {
            return
        }
        
        containerContent = containerContent.filter { (content: ContentType) in
            return existingContent != content
        }
    }
    
    func has(content existingContent: ContentType) -> Bool {
        return containerContent.contains { (content: ContentType) in
            existingContent == content
        }
    }
    
}