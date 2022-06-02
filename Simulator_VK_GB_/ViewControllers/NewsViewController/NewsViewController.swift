//
//  NewsViewController.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 12.05.2022.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let network = NetworkServices()
    var news: News?
    var isLoading = false
    var tableViewWidth: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
        loadDataFromVk()
        tableViewWidth = Double(tableView.bounds.width)
    }
    
}
