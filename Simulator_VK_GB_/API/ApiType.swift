//
//  ApiType.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 28.04.2022.
//

import Foundation

enum ApiType {
    // MARK: - Кейсы
    case getFriends
    case getGroups
    //
    var userId: String { return Session.shared.userId }
    var token: String { return Session.shared.token }
    var version: String { return "5.131" }
    
    // MARK: - Base URL
    var baseUrl: URL {
        return URL(string: "https://api.vk.com/method/")!
    }
    // MARK: - Headers
    var headers: [String : String] {
        switch self {
        case .getFriends:
            return [
                "access_token" : token,
                "user_id" : userId,
                "order" : "hints",
                "fields" : "photo_200_orig",
                "name_case" : "nom",
                "v" : version ]
        case .getGroups:
            return [
                "access_token": token,
                "extended": "1",
                "v": version ]
        }
    }
    // MARK: - Path
    var path: String {
        switch self {
        case .getFriends: return "friends.get"
        case .getGroups: return "groups.get"
            
        }
    }
    // MARK: - Final request
    var request: URLRequest {
        let url = URL(string: path, relativeTo: baseUrl)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        switch self {
        case .getFriends:
            request.httpMethod = "GET"
            return request
        case .getGroups:
            request.httpMethod = "GET"
            return request
        }
    }
    
}
