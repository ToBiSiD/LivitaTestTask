//
//  CommentEntity+Extensions.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import Foundation
import CoreData

extension CommentEntity {
    convenience init(context: NSManagedObjectContext, commentData: CommentData) {
        self.init(context: context)
        self.id = Int64(commentData.id)
        self.postId = Int64(commentData.postId)
        self.name = commentData.name
        self.body = commentData.body
        self.email = commentData.email
    }
    
    func toCommentData() -> CommentData {
        CommentData(
            id: Int(id),
            postId: Int(postId),
            name: name,
            body: body,
            email: email
        )
    }
}
