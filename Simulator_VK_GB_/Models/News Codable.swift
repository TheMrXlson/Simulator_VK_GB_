//
//  News Codable.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 21.05.2022.
//

import Foundation

protocol PostCellProtocol {
    func set<T: PostCellDataProtocol>(value: T, tableViewWidth: Double)
}

protocol PostCellDataProtocol {
    var text: String? { get }
    var attachments: [Attachment]? { get }
}

// MARK: - News
struct NewsJson: Codable {
    let response: News
}

// MARK: - Response
struct News: Codable {
    var groups: [Group]
    var items: [Item]
    var profiles: [Profile]
    var nextFrom: String

    enum CodingKeys: String, CodingKey {
        case groups, items, profiles
        case nextFrom = "next_from"
    }
}

// MARK: - Group
struct Group: Codable {
    let name: String
    let photo50: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case photo50 = "photo_50"
        case id
    }
}

// MARK: - Item
struct Item: Codable, PostCellDataProtocol {
    
    enum PostType: String {
        case image = "ImageCell"
        case text = "TextCell"
        case imagePlusText = "Image+TextCell"
    }
    
    var postType: PostType? {
        let hasImage = attachments?.first?.photo?.sizes.first?.url != nil
        let hasText = text != ""

        switch(hasImage, hasText) {
        case (true, false): return .image
        case (false, true): return .text
        case (true, true): return .imagePlusText
        case(false,false): return nil
        }
    }
    
    let views: Views
    let reposts: Reposts
    let sourceID: Int
    let likes: Likes
    let comments: Comments
    let date: Int
    let attachments: [Attachment]?
    let text: String?

    enum CodingKeys: String, CodingKey {
        case views
        case reposts
        case sourceID = "source_id"
        case likes
        case comments
        case date
        case attachments
        case text

    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let type: String
    let photo: Photo?
}

// MARK: - Photo
struct Photo: Codable {
    let sizes: [Size]

    enum CodingKeys: String, CodingKey {
        case sizes
    }
}

// MARK: - Size
struct Size: Codable {
    let type: String
    let height: Int
    let url: String
    let width: Int
}

// MARK: - Comments
struct Comments: Codable {
    let canPost, count: Int

    enum CodingKeys: String, CodingKey {
        case canPost = "can_post"
        case count
    }
}

// MARK: - Likes
struct Likes: Codable {
    let canLike, userLikes, count, canPublish: Int

    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case userLikes = "user_likes"
        case count
        case canPublish = "can_publish"
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    let userReposted, count: Int

    enum CodingKeys: String, CodingKey {
        case userReposted = "user_reposted"
        case count
    }
}

// MARK: - Views
struct Views: Codable {
    let count: Int
}

// MARK: - Profile
struct Profile: Codable {
    let id: Int
    let photo50: String
    let lastName: String
    let firstName: String

    enum CodingKeys: String, CodingKey {
        case id
        case photo50 = "photo_50"
        case lastName = "last_name"
        case firstName = "first_name"
    }
}
