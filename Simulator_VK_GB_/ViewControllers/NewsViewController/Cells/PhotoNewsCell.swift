//
//  PhotoNewsCell.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 12.05.2022.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    
    func configure(news: NewsItems) {
        let url = URL(string: news.photoUrl)
        if let data = try? Data(contentsOf: url!)
        {
            photo.image = UIImage(data: data)
        }
    }
}
