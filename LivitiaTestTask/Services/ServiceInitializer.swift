//
//  ServiceInitializer.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import Foundation
import CoreData

final class ServicesInitializer {
    @Provider var dataStorage = CDStorageService() as DataStorage
    
    init() {
        @Provider var networkService = NetworkLoadService() as NetworkLoadProtocol
        @Provider var apiService = PostsLoaderService(loadService: networkService) as PostAPIProtocol
    }
    
    public func addDependecy<T: Any>(_ dependecy: T) {
        @Provider var newDependecy = dependecy
    }
    
    public var viewContext: NSManagedObjectContext {
        guard let context = dataStorage.context as? NSManagedObjectContext  else {
            fatalError("NSManagedObjectContext is not find in dataStorage.")
        }
        
        return context
    }
}
