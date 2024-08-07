//
//  Injector.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import Foundation

@propertyWrapper struct Inject<T> {
    var wrappedValue: T
    
    init() {
        self.wrappedValue = DependencyInjector.resolve()
    }
}


