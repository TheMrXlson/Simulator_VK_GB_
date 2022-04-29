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
    
    func getFriends(completion: @escaping (Result<[Friends], Error>) -> Void) {
        
        AF.request(ApiType.getFriends.request)
          .validate()
          .response { response in
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
    
    
    
    func vkGroupList(completion: @escaping (Result<[Groups], Error>) -> Void) {
        
        AF.request(ApiType.getGroups.request)
            .validate()
            .response { response in
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
