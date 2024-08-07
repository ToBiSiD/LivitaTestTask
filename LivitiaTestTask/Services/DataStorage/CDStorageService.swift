//
//  CDStorage.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import Foundation
import CoreData

final class CDStorageService: DataStorage {
    private static let containerName: String = "LivitiaTestTask"
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CDStorageService.containerName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: StorageContext {
        persistentContainer.viewContext
    }
    
    func isDataEmty<T: StorableData>(for dataType: T.Type) -> Bool {
        fetchData(for: T.self).isEmpty
    }
    
    func fetchData<T: StorableData>(for dataType: T.Type) -> [T] {
        guard T.self is NSManagedObject.Type else {
            Logger.printLog("Error fetching \(T.self).Required type is not NSManagedObject", place: .coreData, type: .error)
            return []
        }
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: String(describing: T.self))
        
        do {
            let entities = try persistentContainer.viewContext.fetch(fetchRequest) as? [T]
            return entities ?? []
        } catch {
            Logger.printLog("Error fetching entities: \(error)", place: .coreData, type: .error)
            return []
        }
    }
    
    func fetchData<T: StorableData>() -> [T] {
        return fetchData(for: T.self)
    }
    
    func save() {
        if persistentContainer.viewContext.hasChanges {
            do {
                try  persistentContainer.viewContext.save()
            } catch {
                Logger.printLog("Saving error: \(error)", place: .coreData, type: .error)
            }
        }
    }
    
    func saveData<T: StorableData>(_ data: T) {
        guard let coreDataObject = data as? NSManagedObject else {
            Logger.printLog("Error casting \(T.self) to NSManagedObject", place: .coreData, type: .error)
            return
        }
        
        var newItem: NSManagedObject
        if let existingObject = try? persistentContainer.viewContext.existingObject(with: coreDataObject.objectID) {
            newItem = existingObject
        } else {
            newItem = NSManagedObject(entity: coreDataObject.entity, insertInto: persistentContainer.viewContext)
        }
        
        let attributes = coreDataObject.entity.attributesByName
        for (attributeName, _) in attributes {
            if let value = coreDataObject.value(forKey: attributeName) {
                newItem.setValue(value, forKey: attributeName)
            }
        }
        
        save()
    }
    
    
    func removeData<T : StorableData>(_ data: T) {
        singleRemoveData(data)
        save()
    }
    
    func removeDataRange<T: StorableData>(_ dataRange: [T]) {
        dataRange.forEach { removeData($0) }
        save()
    }
    
    private func singleRemoveData<T: StorableData>(_ data: T) {
        guard let objectToRemove = data as? NSManagedObject else {
            Logger.printLog("Error casting \(T.self).Required type is not NSManagedObject", place: .coreData, type: .error)
            return
        }
        
        persistentContainer.viewContext.delete(objectToRemove)
    }
}
