//
//  AddContactsTableViewCell.swift
//  AmicoLive
//
//  Created by Invision on 17/12/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import UIKit

class AddContactsTableViewCell: UITableViewCell {

	@IBOutlet weak var titleButton: UIButton!
	var title:String?{
		didSet{
			titleButton.setTitle(title, for: .normal)
		}
	}

}
