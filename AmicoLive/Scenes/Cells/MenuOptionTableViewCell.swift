//
//  MenuOptionTableViewCell.swift
//  AmicoLive
//
//  Created by Invision on 28/11/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import UIKit

class MenuOptionTableViewCell: UITableViewCell {
	
	@IBOutlet weak var borderView: UIView!
	@IBOutlet weak var _imageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	
	var option: MenuOption!{
		didSet{
			_imageView.image = option.image
			titleLabel.text = option.title
		}
	}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
