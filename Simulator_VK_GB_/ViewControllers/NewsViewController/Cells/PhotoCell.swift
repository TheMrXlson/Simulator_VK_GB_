//
//  PhotoNewsCell.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 12.05.2022.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    @IBOutlet weak var photo: UIImageView!
}

extension PhotoCell: PostCellProtocol {
    func set<T>(value: T) where T : PostCellDataProtocol {
        
        if let photoUrl = value.attachments?[0].photo?.sizes.filter ({ $0.height == 604 }).first {
            let url = URL(string: photoUrl.url)
            photo.kf.setImage(with: url)
        } else {
            guard let photoUrl = value.attachments?[0].photo?.sizes.last?.url else { return }
            let url = URL(string: photoUrl)
            photo.kf.setImage(with: url)
        }
    }
}

