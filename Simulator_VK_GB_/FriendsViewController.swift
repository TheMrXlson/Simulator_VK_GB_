//
//  FriendsViewController.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 29.04.2022.
//

import UIKit

class FriendsViewController: UIViewController {

    let request = NetworkServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        request.getFriends { result in
            print(result.self)
            }
        
         
          }
    }
