//
//  GroupsViewController + FillData.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 09.05.2022.
//
import UIKit
import RealmSwift
import PromiseKit

extension GroupsViewController {
    
    func loadDataFromVKToRealm() {
       // Вариант с раскрытием в PromiseKit
        firstly {
            networkServices.getGroups()
        }.map { json in
            json["response"]["items"].arrayValue.map{ Groups(json: $0)}
        }.done {
            try? RealmService.save(items: $0, update: .modified)
        }.catch { error in
            print(error)
        }
                                                      }
    func changeRealmCollection() {
        guard let groups = groups else { return }
        self.token = groups.observe { (change: RealmCollectionChange) in
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
