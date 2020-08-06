//
//  HeaderLogoView.swift
//  AmicoLive
//
//  Created by Invision on 30/11/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import UIKit
import Contacts
class HeaderLogoView: UIView {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		let image = #imageLiteral(resourceName: "amico_live_banner")
		let imageView = UIImageView(image: image)
		let height = image.size.height
		let width = UIScreen.main.bounds.width
		imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
		imageView.autoresizingMask = .flexibleHeight
		self.frame = CGRect(x: 0, y: 0, width: width, height: height)
		addSubview(imageView)
	}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
