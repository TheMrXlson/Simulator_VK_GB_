//
//  FriendsViewController + FillData.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 08.05.2022.
//

import UIKit
import RealmSwift

extension FriendsViewController {
    
    func loadDataFromVKToRealm() {

        networkServices.getFriends { result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(friend):
                try? self.realm.save(items: friend, update: .modified)
                self.tableView.reloadData()
            }
        }
    }
    
    func changeRealmCollection() {
        guard let friend = friend else { return }
        self.token = friend.observe { (change: RealmCollectionChange) in
            switch change {
            case .initial:
                self.tableView.reloadData()
            case let .update ( _, deletions, insertions, modifications):
                self.tableView.beginUpdates()
                self.tableView.insertRows(at:insertions.map({IndexPath(row:$0,
                                                                       section:0)}),
                                          with: .automatic)
                self.tableView.deleteRows(at:deletions.map({IndexPath(row:$0,
                                                                      section:0)}),
                                          with:.automatic)
                self.tableView.reloadRows(at:modifications.map({IndexPath(row:$0,
                                                                          section:0)}),
                                          with:.automatic)
                self.tableView.endUpdates()
                
            case let .error (error):
                print("\(error)")
            }
        }
    }
    
}
