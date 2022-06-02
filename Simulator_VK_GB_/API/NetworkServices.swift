//
//  NetworkServices.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 25.04.2022.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

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
    
    func getFriends() -> Promise<[Friends]> {
        
        let path = "/method/friends.get"
        
        let parameters = [
            "access_token" : token,
            "owner_id" : userId,
            "order" : "hints",
            "fields" : "photo_200_orig",
            "name_case" : "nom",
            "v" : version
        ]
        
        let promise = Promise<[Friends]> { resolver in
            AF.request(host + path, parameters: parameters).response { response in
                switch response.result {
                case .failure(let error):
                    resolver.reject(error)
                case .success(let data):
                    guard let data = data,
                          let json = try? JSON(data: data) else { return }
                    let friendsJson = json["response"]["items"].arrayValue
                    let friends = friendsJson.map { Friends(json: $0) }
                    resolver.fulfill(friends)
                }
            }
        }
        return promise
    }
    
    // Вариант с раскрытием в PromiseKit
    func getGroups() -> Promise<JSON> {
        
        let path = "/method/groups.get"
        
        let parameters: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": version
        ]
        
        let promise = Promise<JSON> { resolver in
            AF.request(host + path, parameters: parameters).response { response in
                switch response.result {
                case .failure(let error):
                    resolver.reject(error)
                case .success(let data):
                    guard let data = data,
                          let json = try? JSON(data: data) else { return }
                    resolver.fulfill(json)
                }
            }
        }
        return promise
    }
    
    func getNews() -> Promise<News> {
        
        let path = "/method/newsfeed.get"
        
        let parameters: Parameters = [
            "access_token" : token,
            "filters" : "post",
            "count" : "10",
            "v": version
        ]
        let promise = Promise<News> { resolver in
            AF.request(host + path, method: .get, parameters: parameters).response { response in
                switch response.result {
                case .failure(let error):
                    resolver.reject(error)
                case .success(let data):
                    guard let data = data,
                          let result = try? JSONDecoder().decode(NewsJson.self, from: data) else { return }
                    let news = result.response
        
                    resolver.fulfill(news)
                }
            }
        }
        return promise
    }
    func getNextNews(nextFrom: String) -> Promise<News> {
        let path = "/method/newsfeed.get"
        
        let parameters: Parameters = [
            "access_token" : token,
            "filters" : "post",
            "count" : "10",
            "start_from": nextFrom,
            "v": version
        ]
        let promise = Promise<News> { resolver in
            AF.request(host + path, method: .get, parameters: parameters).response { response in
                switch response.result {
                case .failure(let error):
                     resolver.reject(error)
                case .success(let data):
                    guard let data = data,
                          let result = try? JSONDecoder().decode(NewsJson.self, from: data) else { return }
                    let news = result.response
                    resolver.fulfill(news)
                }
            }
        }
        return promise
    }
}

