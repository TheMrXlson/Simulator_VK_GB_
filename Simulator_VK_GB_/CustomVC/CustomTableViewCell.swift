//
// 
//  Simulator vk SB
//
//  Created by Egor Efimenko on 11.11.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        nameLabel.text = nil
    }

    func configure(image: UIImage?, text: String?) {
        avatarImageView.image = image
        nameLabel.text = text
    }
    
    func configure(friend: Friends) {

    }
    
    func configure(group: Groups) {

    }
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
