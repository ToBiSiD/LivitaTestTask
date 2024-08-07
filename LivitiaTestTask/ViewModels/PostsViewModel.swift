//
//  PostsViewModel.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import Foundation
import CoreData

final class PostsViewModel: ObservableObject {
    @Published private(set) var state: DataState
    @Published private(set) var posts: [PostData] = []
    
    @Inject private var apiService: PostAPIProtocol
    @Inject private var storage: DataStorage
    
    private let userId: Int
    
    init(_ userId: Int = 1) {
        self.userId = userId
        self.state = .uninitialized
        initialize()
    }
}

private extension PostsViewModel {
    func initialize() {
        fetchPosts()
    }
    
    func fetchPosts() {
        posts.removeAll()
        
        guard !tryGetFromCache() else { 
            state = .ready
            return
        }
        
        Task {
            do {
                let posts = try await apiService.fetchPosts(for: userId)
                DispatchQueue.main.async { [weak self] in
                    self?.cachePosts(posts)
                    self?.posts = posts
                    self?.state = .ready
                }
            } catch {
                
            }
        }
    }
    
    func tryGetFromCache() -> Bool {
        let cached: [PostEntity] = storage.fetchData()
        if !cached.isEmpty {
            posts = cached.map({ $0.toPostData() }).filter({ $0.userId == userId })
        }
        
        return !posts.isEmpty
    }
    
    func cachePosts(_ value: [PostData]) {
        guard let viewContext = storage.context as? NSManagedObjectContext else {
            return
        }
        
        value.forEach { data in
            let toSave = PostEntity(context: viewContext, postData: data)
            storage.saveData(toSave)
        }
        
        Logger.printLog("Cache posts \(value.count)", type: .action)
    }
}
