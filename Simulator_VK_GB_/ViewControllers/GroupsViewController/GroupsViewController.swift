//
//  GroupsViewController.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 09.05.2022.
//

import UIKit
import RealmSwift

class GroupsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let reuseIdentifier = "customCellReuseIdentifier"
    let networkServices = NetworkServices()
    var token: NotificationToken?
    var groups: Results<Groups>? = try? Realm(configuration: RealmService.deleteIfMigration).objects(Groups.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDataFromVKToRealm()
        changeRealmCollection()
        
        configureTableView()
        
    }
    

}
