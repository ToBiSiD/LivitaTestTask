//
//  PostsLoaderService.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import Foundation
import Combine

protocol PostAPIProtocol {
    func fetchUsers() -> AnyPublisher<[UserData], Error>
    func fetchPosts(for userId: Int) -> AnyPublisher<[PostData], Error>
    func fetchComments(for postId: Int) -> AnyPublisher<[CommentData], Error>
    
    func fetchUsers() async throws  -> [UserData]
    func fetchPosts(for userId: Int) async throws -> [PostData]
    func fetchComments(for postId: Int) async throws -> [CommentData]
}

final class PostsLoaderService: PostAPIProtocol {
    private let loadService: NetworkLoadProtocol
    
    init(loadService: NetworkLoadProtocol) {
        self.loadService = loadService
    }
}


//MARK: - Combine workflow
extension PostsLoaderService {
    func fetchUsers() -> AnyPublisher<[UserData], Error> {
        let url = URL(string: PostsLinkBuilder.buildUserLink())
        return combineFetch(url)
            .eraseToAnyPublisher()
    }
    
    func fetchPosts(for userId: Int) -> AnyPublisher<[PostData], Error> {
        let url = URL(string: PostsLinkBuilder.buildPostLink(for: userId))
        return combineFetch(url)
            .eraseToAnyPublisher()
    }
    
    func fetchComments(for postId: Int) -> AnyPublisher<[CommentData], Error> {
        let url = URL(string: PostsLinkBuilder.buildCommentLink(for: postId))
        return combineFetch(url)
            .eraseToAnyPublisher()
    }
    
    private func combineFetch<T: Decodable>(_ url: URL?) -> AnyPublisher<T, Error> {
        return loadService.fetchData(for: url)
            .eraseToAnyPublisher()
    }
}

//MARK: - Swift Concurrency workflow
extension PostsLoaderService {
    func fetchUsers() async throws -> [UserData] {
        let url = URL(string: PostsLinkBuilder.buildUserLink())
        return try await asyncFetch(url)
    }
    
    func fetchPosts(for userId: Int) async throws -> [PostData] {
        let url = URL(string: PostsLinkBuilder.buildPostLink(for: userId))
        return try await asyncFetch(url)
    }
    
    func fetchComments(for postId: Int) async throws -> [CommentData] {
        let url = URL(string: PostsLinkBuilder.buildCommentLink(for: postId))
        return try await asyncFetch(url)
    }
    
    private func asyncFetch<T: Decodable>(_ url: URL?) async throws -> T {
        try await loadService.fetchData(for: url)
    }
}
