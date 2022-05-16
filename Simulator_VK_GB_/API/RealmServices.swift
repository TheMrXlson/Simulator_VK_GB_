//
//  RealmServices.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 05.05.2022.
//

import Foundation
import RealmSwift

class RealmService {
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    static func save<T: Object>(
        items: [T],
        configuration: Realm.Configuration = deleteIfMigration,
        update: Realm.UpdatePolicy
    ) throws {
        let realm = try Realm(configuration: configuration)
        print(configuration.fileURL ?? "")
        try realm.write {
            realm.add(items, update: update)
        }
    }
    
    static func get<T: Object>(_ type: T.Type,
        configuration: Realm.Configuration = deleteIfMigration) throws -> Results<T> {
        let realm = try Realm(configuration: configuration)
        return realm.objects(type)
    }
}
