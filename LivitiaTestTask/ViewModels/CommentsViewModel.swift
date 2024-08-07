//
//  CommentsViewModel.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import Foundation
import CoreData


final class CommentsViewModel: ObservableObject {
    @Published private(set) var state: DataState
    @Published private(set) var comments: [CommentData] = []
    @Published private(set) var title: String = "Comments"
    
    @Inject private var apiService: PostAPIProtocol
    @Inject private var storage: DataStorage
    
    private let postId: Int
    
    init(_ postId: Int = 1) {
        self.postId = postId
        self.state = .uninitialized
        initialize()
        
        self.title = self.title + " (\(comments.count))"
    }
}

private extension CommentsViewModel {
    func initialize() {
        fetchComments()
    }
    
    func fetchComments() {
        comments.removeAll()
        
        guard !tryGetFromCache() else {
            state = .ready
            return
        }
        
        Task {
            do {
                let comments = try await apiService.fetchComments(for: postId)
                DispatchQueue.main.async { [weak self] in
                    self?.cacheComments(comments)
                    self?.comments = comments
                    self?.state = .ready
                }
            } catch {
                
            }
        }
    }
    
    func tryGetFromCache() -> Bool {
        let cached: [CommentEntity] = storage.fetchData()
        if !cached.isEmpty {
            comments = cached.map({ $0.toCommentData() }).filter({ $0.postId == postId })
        }
        
        return !comments.isEmpty
    }
    
    func cacheComments(_ value: [CommentData]) {
        guard let viewContext = storage.context as? NSManagedObjectContext else {
            return
        }
        
        value.forEach { data in
            let toSave = CommentEntity(context: viewContext, commentData: data)
            storage.saveData(toSave)
        }
        
        Logger.printLog("Cache comments \(value.count)", type: .action)
    }
}
