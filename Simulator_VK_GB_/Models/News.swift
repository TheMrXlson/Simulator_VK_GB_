//
//  News.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 12.05.2022.
//
import SwiftyJSON

struct NewsObject {
    var groups: [NewsGroups]
    var items: [NewsItems]
    //var profiles: [NewsProfiles]
}

class NewsGroups {
    
    var id: Int = 0
    var name: String = ""
    var photo_50: String = ""
    
    convenience init (json: SwiftyJSON.JSON) {
        self.init()
        
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.photo_50 = json["photo_50"].stringValue
    }
}

class NewsItems {
    
    var sourceId: Int = 0
    var type: String = ""
    var text: String = ""
    var commentsCount: Int = 0
    var likesCount: Int = 0
    var repostsCount: Int = 0
    var viewsCount: Int = 0
    var photoUrl: String = ""
    var date: Int = 0
    
    convenience init (json: SwiftyJSON.JSON) {
        self.init()
        
        self.sourceId = json["source_id"].intValue
        self.type = json["type"].stringValue
        self.text = json["text"].stringValue
        self.likesCount = json["likes"]["count"].intValue
        self.commentsCount = json["comments"]["count"].intValue
        self.repostsCount = json["reposts"]["count"].intValue
        self.viewsCount = json["views"]["count"].intValue
        self.date = json["date"].intValue
        
        let sizes = json["attachments"][0]["photo"]["sizes"].arrayValue
        if let photoUrl = sizes.filter ({ $0["height"] == 604 }).first {
            self.photoUrl = photoUrl["url"].stringValue
        } else {
            if let photoUrl = sizes.last {
                self.photoUrl = photoUrl["url"].stringValue
                
            }
        }
    }
}
class NewsProfiles {
    
}
