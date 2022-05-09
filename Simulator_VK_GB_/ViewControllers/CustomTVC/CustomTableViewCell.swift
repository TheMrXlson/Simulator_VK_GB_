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
    
    func configure(friends: Friends) {
        let url = friends.friendAvatar
        if let data = try? Data(contentsOf: url!)
        {
            avatarImageView.image = UIImage(data: data)
        }
        
        nameLabel.text = friends.firstName + " " + friends.secondName
    }
    
    func configure(groups: Groups) {
        let url = groups.avatar
        if let data = try? Data(contentsOf: url!)
        {
            avatarImageView.image = UIImage(data: data)
        }
        
        nameLabel.text = groups.name
    }
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
