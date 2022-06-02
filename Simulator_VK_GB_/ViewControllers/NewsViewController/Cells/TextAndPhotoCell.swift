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
    @IBOutlet weak var imageHight: NSLayoutConstraint!
    
}

extension PhotoAndTextCell: PostCellProtocol {
    func set<T>(value: T, tableViewWidth: Double) where T : PostCellDataProtocol {
        textNews.text = value.text
        guard let photoUrl = value.attachments?[0].photo?.sizes.filter ({ $0.type == "x" }).first else { return }
        let url = URL(string: photoUrl.url)
            imageNews.kf.setImage(with: url)
        
        let height = CGFloat(photoUrl.height)
        let width = CGFloat(photoUrl.width)
        let aspectRatio = height / width
        let resultimageHight = tableViewWidth * aspectRatio
        imageHight.constant = resultimageHight
    }
}
