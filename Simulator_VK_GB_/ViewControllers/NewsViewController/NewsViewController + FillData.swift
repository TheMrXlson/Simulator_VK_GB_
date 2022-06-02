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
        
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Потяни сильнее, чтобы перезагрузить")
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func refreshData(_ sender: UIRefreshControl) {
        defer { sender.endRefreshing() } // Чтобы не забыть выполнить
        loadDataFromVk()
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
    
    func loadNextData() {
        guard let nextFrom = news?.nextFrom else { return }
        firstly {
            network.getNextNews(nextFrom: nextFrom)
        }.done { result in
            self.news?.nextFrom = result.nextFrom
            self.news?.items.append(contentsOf: result.items)
            self.news?.groups.append(contentsOf: result.groups)
            self.news?.profiles.append(contentsOf: result.profiles)
            self.tableView.reloadData()
            self.isLoading = false
        }.catch { error in
            print(error)
        }
    }
}
