//
//  Provider.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import Foundation

@propertyWrapper struct Provider<T> {
    var wrappedValue: T
    
    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        DependencyInjector.register(wrappedValue)
    }
}
