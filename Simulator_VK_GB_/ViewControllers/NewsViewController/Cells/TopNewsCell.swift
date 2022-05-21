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
    
    func configure(news: Item, group: [Group]) {
        
        let sourceId = news.sourceID
        guard let selectedGroup = group.filter({ $0.id == -sourceId }).first else { return }

        let url = URL(string: selectedGroup.photo50)
        avatarGroup.kf.setImage(with: url)
        nameGroup.text = selectedGroup.name
        avatarGroup.layer.cornerRadius = avatarGroup.frame.height/2
    }
}
