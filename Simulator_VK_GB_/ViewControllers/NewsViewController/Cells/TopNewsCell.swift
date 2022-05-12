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
    
    func configure(news:NewsGroups, time:NewsItems) {
        
        let url = URL(string: news.photo_50)
        if let data = try? Data(contentsOf: url!)
        {
            avatarGroup.image = UIImage(data: data)
        }
        nameGroup.text = news.name
        publicationTime.text = "\(time.date)"
        avatarGroup.layer.cornerRadius = avatarGroup.frame.height/2
    }
}
