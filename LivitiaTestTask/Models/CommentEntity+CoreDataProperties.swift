//
//  CommentEntity+CoreDataProperties.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//
//

import Foundation
import CoreData


extension CommentEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CommentEntity> {
        return NSFetchRequest<CommentEntity>(entityName: "CommentEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var postId: Int64
    @NSManaged public var name: String
    @NSManaged public var body: String
    @NSManaged public var email: String

}

extension CommentEntity : Identifiable {

}
