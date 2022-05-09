//
//  FriendsViewController.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 08.05.2022.
//

import UIKit
import RealmSwift

class FriendsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let reuseIdentifier = "customCellReuseIdentifier"
    let networkServices = NetworkServices()
    var token: NotificationToken?
    var friend: Results<Friends>? = try? Realm(configuration: RealmService.deleteIfMigration).objects(Friends.self)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadDataFromVKToRealm()
        changeRealmCollection()
        
        configureTableView()

    }
    
}
