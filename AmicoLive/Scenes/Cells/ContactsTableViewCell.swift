//
//  ContactsTableViewCell.swift
//  AmicoLive
//
//  Created by Invision on 08/01/2019.
//  Copyright © 2019 Invision. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

	@IBOutlet weak var userNameLabel: UILabel!
	var name:String?{
		didSet{
			userNameLabel.text = name
		}
	}
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
