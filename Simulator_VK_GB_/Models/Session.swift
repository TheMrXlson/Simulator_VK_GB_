//
//  Session.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 25.04.2022.
//

import Foundation

class Session {
    
    var token: String = ""
    var userId: String = ""
    
    convenience init(token: String, userId: String) {
        self.init()
        self.token = token
        self.userId = userId
    }
    public static let shared = Session()
    
}
