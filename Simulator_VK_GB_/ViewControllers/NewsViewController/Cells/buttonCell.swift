//
//  buttonNewsCell.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 12.05.2022.
//

import UIKit

class ButtonCell: UITableViewCell {
    
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var repostCount: UILabel!
    @IBOutlet weak var viewCount: UILabel!
    
    func configure(news: Item) {
        likeCount.text = "\(news.likes.count)"
        commentCount.text = "\(news.likes.count)"
        repostCount.text = "\(news.reposts.count)"
        viewCount.text = "\(news.views.count)"
    }
}
