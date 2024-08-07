//
//  UserEntity+CoreDataProperties.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String
    @NSManaged public var email: String
    @NSManaged public var username: String
    @NSManaged public var phone: String
    @NSManaged public var website: String
    @NSManaged public var street: String
    @NSManaged public var suite: String
    @NSManaged public var city: String
    @NSManaged public var zipcode: String
    @NSManaged public var lat: String
    @NSManaged public var lng: String
    @NSManaged public var compName: String
    @NSManaged public var catchPhrase: String
    @NSManaged public var bs: String

}

extension UserEntity : Identifiable {

}
