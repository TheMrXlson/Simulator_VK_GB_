//
//  TextAndPhotoCell.swift
//  Simulator_VK_GB_
//
//  Created by Egor Efimenko on 18.05.2022.
//

import UIKit

class PhotoAndTextCell: UITableViewCell {
    
    @IBOutlet weak var textNews: UILabel!
    @IBOutlet weak var imageNews: UIImageView!
    
}

extension PhotoAndTextCell: PostCellProtocol {
    func set<T>(value: T) where T : PostCellDataProtocol {
        textNews.text = value.text
        if let photoUrl = value.attachments?[0].photo?.sizes.filter ({ $0.height == 604 }).first {
            let url = URL(string: photoUrl.url)
            imageNews.kf.setImage(with: url)
        } else {
            guard let photoUrl = value.attachments?[0].photo?.sizes.last?.url else { return }
            let url = URL(string: photoUrl)
            imageNews.kf.setImage(with: url)
        }
    }
}
