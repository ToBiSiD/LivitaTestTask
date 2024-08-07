//
//  PostsLinkBuilder.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import Foundation

struct PostsLinkBuilder {
    private static let baseLink: String = "https://jsonplaceholder.typicode.com"
    
    static func buildUserLink() -> String {
        return baseLink + "/users"
    }
    
    static func buildPostLink(for userId: Int = 1) -> String {
        return baseLink + "/posts?userId=\(userId)"
    }
    
    static func buildCommentLink(for postId: Int) -> String {
        return baseLink + "/comments?postId=\(postId)"
    }
}
