//
//  Friends.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 27.04.2022.
//

import Foundation
import SwiftyJSON

class Friends {
    
    var firstName = ""
    var lastName = ""
    var friendImageUrlText = ""
    var friendAvatar: URL? { URL(string: "\(friendImageUrlText)") }
    
    
    convenience init(json: SwiftyJSON.JSON) {
        self.init()
        
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.friendImageUrlText = json["photo_200_orig"].stringValue
    }
    
}
