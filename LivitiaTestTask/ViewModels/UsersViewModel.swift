//
//  UsersViewModel.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import Foundation
import CoreData


final class UsersViewModel: ObservableObject {
    @Published private(set) var state: DataState
    @Published private(set) var users: [UserData] = []
    
    @Inject private var apiService: PostAPIProtocol
    @Inject private var storage: DataStorage
    
    init() {
        self.state = .uninitialized
        initialize()
    }
}

private extension UsersViewModel {
    func initialize() {
        fetchUsers()
    }
    
    func fetchUsers() {
        guard !tryGetFromCache() else { return }
        
        Task {
            do {
                let users = try await apiService.fetchUsers()
                DispatchQueue.main.async { [weak self] in
                    self?.cacheUsers(users)
                    self?.users = users
                    self?.state = .ready
                }
            } catch {
                
            }
        }
    }
    
    func tryGetFromCache() -> Bool{
        let cached: [UserEntity] = storage.fetchData()
        if !cached.isEmpty {
            users = cached.map({ $0.toUserData() })
            state = .ready
        }
        
        return !users.isEmpty
    }
    
    func cacheUsers(_ value: [UserData]) {
        guard let viewContext = storage.context as? NSManagedObjectContext else {
            return
        }
        
        value.forEach { user in
            let toSave = UserEntity(context: viewContext, userData: user)
            storage.saveData(toSave)
        }
        
        Logger.printLog("Cache users \(value.count)", type: .action)
    }
}
