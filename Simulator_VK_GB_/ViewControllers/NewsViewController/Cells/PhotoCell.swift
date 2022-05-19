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
        guard let photoUrl = value.photoUrl,
              let url = URL(string: photoUrl) else {return}
        photo.kf.setImage(with: url)
    }
}

