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
    var news: NewsObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        network.getNews { [weak self] result in
            self?.news = result
            self?.tableView.reloadData()
        }

    }

}
extension NewsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return news?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "topNewsCellID", for: indexPath) as? TopCell
            
            guard let cell = cell, let news = news else {
                return UITableViewCell()
            }
            cell.configure(news: news.groups[indexPath.section], time: news.items[indexPath.section])
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textNewsCellID", for: indexPath) as? TextCell
            
            guard let cell = cell, let news = news else {
                return UITableViewCell()
            }
                
            let newsItems = news.items[indexPath.section]
            cell.configure(news: newsItems)
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageNewsCellID", for: indexPath) as? PhotoCell
            
            guard let cell = cell, let news = news else {
                return UITableViewCell()
            }
            
            let newsItems = news.items[indexPath.section]
            cell.configure(news: newsItems)
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "bottomNewsCellID", for: indexPath) as? ButtonCell
            
            guard let cell = cell, let news = news else {
                return UITableViewCell()
            }
            
            let newsItems = news.items[indexPath.section]
            cell.configure(news: newsItems)
            return cell
        }
    }
}
extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let newsItems = news?.items[indexPath.section]
        
        if indexPath.row == 1 && ((newsItems?.text.rangeOfCharacter(from: CharacterSet.letters)) != nil) != true { // Проверка на наличие текста в новости
            return 0
        } else if indexPath.row == 2 && newsItems?.photoUrl.contains("https") != true { // Проверка на наличие фото в новости
            return 0
        } else {
            return UITableView.automaticDimension
        }
    }
}
