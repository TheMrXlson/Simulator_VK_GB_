//
//  GroupsViewController + TableViewDelegate.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 09.05.2022.
//

import UIKit

extension GroupsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
