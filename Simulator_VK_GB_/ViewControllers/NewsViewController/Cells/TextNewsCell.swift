//
//  textNewsCell.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 12.05.2022.
//

import UIKit

class TextCell: UITableViewCell {
    
    @IBOutlet weak var textView: UILabel!
    
    func configure(news: NewsItems) {
        textView.text = news.text
    }
}
