//
//  RealmServices.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 05.05.2022.
//

import Foundation
import RealmSwift
import Realm

class RealmService {
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    func save<T: Object>(
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
    
    func save<T: Object>(
        items: [T],
        configuration: Realm.Configuration = deleteIfMigration
    ) throws {
        let realm = try Realm(configuration: configuration)
        print(configuration.fileURL ?? "")
        try realm.write {
            realm.add(items)
        }
    }
}
