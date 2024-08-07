//
//  UserEntity+Extensions.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import Foundation
import CoreData

extension UserEntity {
    func toUserData() -> UserData {
        UserData(id: Int(id), name: name, username: username, email: email, address: .init(street: street, suite: suite, city: city, zipcode: zipcode, geo: .init(lat: lat, lng: lng)), phone: phone, website: website, company: .init(name: compName, catchPhrase: catchPhrase, bs: bs))
    }
    
    convenience init(context: NSManagedObjectContext, userData: UserData) {
        self.init(context: context)
        self.id = Int64(userData.id)
        self.name = userData.name
        self.username = userData.username
        self.email = userData.email
        self.street = userData.address.street
        self.suite = userData.address.suite
        self.city = userData.address.city
        self.zipcode = userData.address.zipcode
        self.lat = userData.address.geo.lat
        self.lng = userData.address.geo.lng
        self.phone = userData.phone
        self.website = userData.website
        self.compName = userData.company.name
        self.catchPhrase = userData.company.catchPhrase
        self.bs = userData.company.bs
    }
}
