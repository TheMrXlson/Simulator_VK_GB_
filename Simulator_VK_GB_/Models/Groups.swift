//
//  Groups.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 27.04.2022.
//
import Foundation
import SwiftyJSON

class Groups {
    
    var name: String = ""
    var photoUrl: String = ""
    var avatar: URL? { URL(string: "\(photoUrl)") }
    
    convenience init(json: SwiftyJSON.JSON) {
        self.init()
        
        self.name = json["name"].stringValue
        self.photoUrl = json["photo_100"].stringValue
    }
}
