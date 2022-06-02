//
//  NewsViewController + TableViewDataSource.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 19.05.2022.
//
import UIKit

extension NewsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return news?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 1:
            guard let cellType = news?.items[indexPath.section].postType else { return 0 }
            switch cellType {
            case .image:    // подгон высоты ячейки под пост (тип поста - только с фото)
                guard let news = self.news?.items[indexPath.section].attachments?.first?.photo?.sizes.first(where: {$0.type == "x"})
                else { return 0 }
                let height = CGFloat(news.height)
                let width = CGFloat(news.width)
                let aspectRatio = height / width
                let cellHight = self.tableViewWidth * aspectRatio
                return cellHight
            default:
                return UITableView.automaticDimension
            }
            
        default:
            return UITableView.automaticDimension
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0: // общая часть для всех постов - название Группы и время публикации
            let cell = tableView.dequeueReusableCell(withIdentifier: "topNewsCellID", for: indexPath) as? TopCell
            
            guard let cell = cell,
                  let newsItems = news?.items[indexPath.section],
                  let groupInfo = news?.groups,
                  let profiles = news?.profiles
            else { return UITableViewCell() }
            
            cell.configure(news: newsItems, group: groupInfo, profiles: profiles)
            
            return cell
            
        case 1: // Сам пост
            guard let data = news?.items[indexPath.section],
                  let cellId = data.postType?.rawValue, // понимаем какой тип поста для выбора верной ячейки
                  let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            else { return UITableViewCell() }
            
            (cell as? PostCellProtocol)?.set(value: data, tableViewWidth: self.tableViewWidth) // Для расчета высоты фото - отправляю ширину экрана устройства
            
            return cell
           
        default: // общая часть дял всех постов - количество лайков, комментариев, репостов и просмотров поста, так же их кнопки
            let cell = tableView.dequeueReusableCell(withIdentifier: "bottomNewsCellID", for: indexPath) as? ButtonCell
            
            guard let cell = cell, let newsItems = news?.items[indexPath.section]
            else { return UITableViewCell() }
            
            cell.configure(news: newsItems)
            return cell
        }
    }
    // Паттерн бесконечной ленты новостей
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        DispatchQueue.global().async {
            guard let count = self.news?.items.count else { return }
            let percent = Double(indexPath.section) / Double(count)
            if percent >= 0.8, !self.isLoading {
                self.isLoading = true
                self.loadNextData()
            }
        }
    }
}
