//
//  NewsViewController + TableViewDataSource.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 19.05.2022.
//
import UIKit

extension NewsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return news?.post.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0: // общая часть для всех постов - название Группы и время публикации
            let cell = tableView.dequeueReusableCell(withIdentifier: "topNewsCellID", for: indexPath) as? TopCell
            
            guard let cell = cell,
                  let newsItems = news?.post[indexPath.section],
                  let news = news?.groupsInfo
            else { return UITableViewCell() }
            
            cell.configure(news: newsItems, group: news)
            
            return cell
            
        case 1: // Сам пост
            guard let data = news?.post[indexPath.section],
                  let cellId = data.postType?.rawValue, // понимаем какой тип поста для выбора верной ячейки
                  let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            else { return UITableViewCell() }
            
            (cell as? PostCellProtocol)?.set(value: data)
            
            return cell
           
        default: // общая часть дял всех постов - количество лайков, комментариев, репостов и просмотров поста, так же их кнопки
            let cell = tableView.dequeueReusableCell(withIdentifier: "bottomNewsCellID", for: indexPath) as? ButtonCell
            
            guard let cell = cell, let newsItems = news?.post[indexPath.section]
            else { return UITableViewCell() }
            
            cell.configure(news: newsItems)
            return cell
        }
    }
}
