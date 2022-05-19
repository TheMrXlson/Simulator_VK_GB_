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
        guard let photoUrl = value.photoUrl,
              let url = URL(string: photoUrl) else { return }
        imageNews.kf.setImage(with: url)
    }
}
