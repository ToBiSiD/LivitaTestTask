//
//  DependencyInjector.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import Foundation

struct DependencyInjector {
    private static var dependencies: [String: Any] = [:]
    
    static func resolve<T>() -> T {
        guard let t = dependencies[String(describing: T.self)] as? T else {
            fatalError()
        }
        
        return t
    }
    
    static func register<T>(_ dependecy: T) {
        dependencies[String(describing: T.self)] = dependecy
    }
}
