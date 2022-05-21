//
//  News.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 18.05.2022.
//
//import SwiftyJSON
//import Foundation
//
//struct News {
//    let groupsInfo: GroupsInfo
//    let post: Posts
//}
//
//typealias GroupsInfo = [GroupInfo]
//typealias Posts = [Post]
//
//class GroupInfo {
//    
//    var id: Int = 0
//    var name: String = ""
//    var photoGroup: String = ""
//    
//    convenience init (json: SwiftyJSON.JSON) {
//        self.init()
//        
//        self.id = json["id"].intValue
//        self.name = json["name"].stringValue
//        self.photoGroup = json["photo_50"].stringValue
//    }
//}
//
//class Post: PostCellDataProtocol {
//
//    enum PostType: String {
//        case image = "ImageCell"
//        case text = "TextCell"
//        case imagePlusText = "Image+TextCell"
//    }
//    
//    var postType: PostType? {
//        let hasImage = photoUrl != nil
//        let hasText = text != nil
//
//        switch(hasImage, hasText) {
//        case (true, false): return .image
//        case (false, true): return .text
//        case (true, true): return .imagePlusText
//        case(false,false): return nil
//        }
//    }
//
//    var sourceId: Int = 0
//    var type: String = ""
//    var text: String? = nil
//    var commentsCount: Int = 0
//    var likesCount: Int = 0
//    var repostsCount: Int = 0
//    var viewsCount: Int = 0
//    var photoUrl: String? = nil
//    var date: String = ""
//    
//    convenience init (json: SwiftyJSON.JSON) {
//        self.init()
//        
//        self.sourceId = json["source_id"].intValue
//        self.type = json["type"].stringValue
//        self.text = json["text"].stringValue
//        self.likesCount = json["likes"]["count"].intValue
//        self.commentsCount = json["comments"]["count"].intValue
//        self.repostsCount = json["reposts"]["count"].intValue
//        self.viewsCount = json["views"]["count"].intValue
//        self.date = json["date"].stringValue
//        
//        let sizes = json["attachments"][0]["photo"]["sizes"].arrayValue
//        if let photoUrl = sizes.filter ({ $0["height"] == 604 }).first {
//            self.photoUrl = photoUrl["url"].stringValue
//        } else {
//            if let photoUrl = sizes.last {
//                self.photoUrl = photoUrl["url"].stringValue
//                
//            }
//        }
//    }
//}

//protocol PostCellProtocol {
//    func set<T: PostCellDataProtocol>(value: T)
//}
//
//protocol PostCellDataProtocol {
//    var text: String? { get }
//    var photoUrl: String? { get }
//}

