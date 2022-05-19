//
//  NewsViewController + FillData.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 19.05.2022.
//

import Foundation
import PromiseKit

extension NewsViewController {
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadDataFromVk() {
        
        firstly {
            network.getNews()
        }.done {
            self.news = $0
            self.tableView.reloadData()
        }.catch { error in
            print(error)
        }
    }
}
