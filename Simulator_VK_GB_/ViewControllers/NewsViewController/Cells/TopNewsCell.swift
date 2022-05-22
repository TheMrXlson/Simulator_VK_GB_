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
    
    func configure(news: Item, group: [Group], profiles: [Profile]) {
        
        
        let url: URL?
        let textResult: String?
        
        let sourceId = news.sourceID
        let selectedGroup = group.filter({ $0.id == -sourceId }).first
        
        if selectedGroup == nil {
            guard let selectedProfile = profiles.filter({ $0.id == sourceId }).first else { return }
            
            url = URL(string: selectedProfile.photo50)
            textResult = selectedProfile.firstName + " " + selectedProfile.lastName
        } else {
            url = URL(string: selectedGroup!.photo50)
            textResult = selectedGroup?.name
        }
        
        avatarGroup.kf.setImage(with: url)
        nameGroup.text = textResult
        avatarGroup.layer.cornerRadius = avatarGroup.frame.height/2
    }
}
