//
//  Comment.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import Foundation

struct CommentData: Codable, Identifiable {
    let id: Int
    let postId: Int
    let name: String
    let body: String
    let email: String
}
