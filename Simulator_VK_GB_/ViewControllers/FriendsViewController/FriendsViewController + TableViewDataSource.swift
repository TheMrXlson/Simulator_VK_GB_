//
//  FriendsViewController + TableViewDataSource.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 08.05.2022.
//
import UIKit

extension FriendsViewController: UITableViewDataSource {
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friend?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CustomTableViewCell,
                  let friends = friend?[indexPath.row] else { return UITableViewCell() }
            cell.configure(friends: friends)
            return cell
    }
    
    
}
