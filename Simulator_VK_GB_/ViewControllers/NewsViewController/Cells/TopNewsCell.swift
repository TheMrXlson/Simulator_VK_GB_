//
//  TopNewsCell.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 12.05.2022.
//

import UIKit

class TopCell: UITableViewCell {
    
    @IBOutlet weak var avatarGroup: UIImageView!
    @IBOutlet weak var nameGroup: UILabel!
    @IBOutlet weak var publicationTime: UILabel!
    
    func configure(news: Post, group: GroupsInfo) {
        
        let sourceId = news.sourceId
        guard let selectedGroup = group.filter({ $0.id == -sourceId }).first else { return }

        let url = URL(string: selectedGroup.photoGroup)
        avatarGroup.kf.setImage(with: url)
        nameGroup.text = selectedGroup.name
        publicationTime.text = news.date
        avatarGroup.layer.cornerRadius = avatarGroup.frame.height/2
    }
}
