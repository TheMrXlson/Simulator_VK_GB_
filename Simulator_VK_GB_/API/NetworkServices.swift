//
//  NetworkServices.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 25.04.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkServices {
    
    private let userId = Session.shared.userId
    private let token = Session.shared.token
    private let host = "https://api.vk.com"
    private let version = "5.131"
    
    // MARK: - Standart SWIFT URLComponents
    func vkLogin() -> URLRequest {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8039339"),
            URLQueryItem(name: "scope", value: "8198"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "user_id", value: "userId"),
            URLQueryItem(name: "v", value: version)
        ]
        let url = urlComponents.url
        let request = URLRequest(url: url!)
        return request
    }
    
    func getFriends(completion: @escaping (Result<[Friends], Error>) -> Void) {
        
        let path = "/method/friends.get"
        
        let parameters = [
            "access_token" : token,
            "owner_id" : userId,
            "order" : "hints",
            "fields" : "photo_200_orig",
            "name_case" : "nom",
            "v" : version
        ]
        
        AF.request(host + path, parameters: parameters).response { response in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                guard let data = data,
                      let json = try? JSON(data: data) else { return }
                let friendsJson = json["response"]["items"].arrayValue
                let friends = friendsJson.map { Friends(json: $0) }
                    completion(.success(friends))
            }
        }
    }
    
    func getGroups(completion: @escaping ([Groups]) -> Void) {
        
        let path = "/method/groups.get"
        
        let parameters: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": version
        ]
        
        AF.request(host + path, parameters: parameters).response { response in
            
            guard let data = response.data,
                  let json = try? JSON(data: data) else { return }
            
            let groupsJson = json["response"]["items"].arrayValue
            let groups = groupsJson.map { Groups(json: $0) }
            completion(groups)
        }
    }
    
    func getNews(completion: @escaping (NewsObject) -> Void) {
        
        let path = "/method/newsfeed.get"
        
        let parameters: Parameters = [
            "access_token" : token,
            "filters" : "post",
            "count" : "10",
            "v": version
        ]
        
        AF.request(host + path, method: .get, parameters: parameters).response { response in
            guard let data = response.data, let json = try? JSON(data: data) else { return }
            let newsGroupsJson = json["response"]["groups"].arrayValue
            let newsItemJson = json["response"]["items"].arrayValue
            let newsGroups = newsGroupsJson.map { NewsGroups(json: $0) }
            let newsItems = newsItemJson.map { NewsItems(json: $0) }
            let result = NewsObject(groups: newsGroups, items: newsItems)
            
            completion(result)
        }
    }
}
