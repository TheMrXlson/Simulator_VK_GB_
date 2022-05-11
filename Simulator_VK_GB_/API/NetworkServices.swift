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
    
    
    func getGroups(completion: @escaping (Result<[Groups], Error>) -> Void) {
        
        let path = "/method/groups.get"
        
        let parameters: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": version
        ]
        
        AF.request(host + path, parameters: parameters).response { response in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                guard let data = data,
                      let json = try? JSON(data: data) else { return }
                
                let groupsJson = json["response"]["items"].arrayValue
                let groups = groupsJson.map { Groups(json: $0) }
                    completion(.success(groups))
            }
        }
        
    }
}

