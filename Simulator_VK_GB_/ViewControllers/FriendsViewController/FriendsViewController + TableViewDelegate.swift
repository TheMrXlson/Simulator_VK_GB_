//
//  FriendsViewController + TableViewDelegate.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 08.05.2022.
//

import UIKit

extension FriendsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
