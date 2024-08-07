//
//  PostEntity+Extensions.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import Foundation
import CoreData

extension PostEntity {
    convenience init(context: NSManagedObjectContext, postData: PostData) {
        self.init(context: context)
        self.id = Int64(postData.userId)
        self.postId = Int64(postData.id)
        self.title = postData.title
        self.body = postData.body
    }
    
    func toPostData() -> PostData {
         PostData(
            id: Int(postId),
            userId: Int(id),
            title: title,
            body: body
        )
    }
}
