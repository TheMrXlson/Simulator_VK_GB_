//
//  Groups.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 27.04.2022.
//
import Foundation
import SwiftyJSON
import RealmSwift

class Groups: Object {
    
    @Persisted(primaryKey: true) var id = ""
    @Persisted var name: String
    @Persisted var photoUrl: String
    var avatar: URL? { URL(string: "\(photoUrl)") }
    
    convenience init(json: SwiftyJSON.JSON) {
        self.init()
        
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        self.photoUrl = json["photo_100"].stringValue
    }
}

