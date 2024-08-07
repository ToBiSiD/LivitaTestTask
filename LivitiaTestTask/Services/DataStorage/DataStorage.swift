//
//  DataStorage.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import Foundation
import CoreData

protocol StorageContext {
}

protocol StorableData {
}

protocol DataStorage {
    var context: StorageContext { get }
    func isDataEmty<T: StorableData>(for dataType: T.Type) -> Bool
    func fetchData<T: StorableData>() -> [T]
    func fetchData<T: StorableData>(for dataType: T.Type) -> [T]
    func save()
    func saveData<T: StorableData>(_ data: T)
    func removeData<T: StorableData>(_ data: T)
    func removeDataRange<T: StorableData>(_ dataRange: [T])
}
