//
//  PostEntity+CoreDataProperties.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//
//

import Foundation
import CoreData


extension PostEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostEntity> {
        return NSFetchRequest<PostEntity>(entityName: "PostEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var postId: Int64
    @NSManaged public var title: String
    @NSManaged public var body: String

}

extension PostEntity : Identifiable {

}
