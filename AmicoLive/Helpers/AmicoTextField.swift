//
//  AmicoTextField.swift
//  AmicoLive
//
//  Created by Invision on 20/12/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable

class AmicoTextField:UITextField{
	@IBInspectable var leftIcon:Bool = false
	@IBInspectable var rightIcon:Bool = false
	
	//Overriding method to change leftview frame
	override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
		var textRect = super.leftViewRect(forBounds: bounds)
		textRect.origin.x += 10
		return textRect
	}
	
	//Overriding method to change rightView frame
	override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
		var textRect = super.rightViewRect(forBounds: bounds)
		textRect.origin.x += 10
		return textRect
	}
	
	override func draw(_ rect: CGRect) {
		
		self.layer.cornerRadius = 12
		let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
		if (leftIcon){
			imageView.image = #imageLiteral(resourceName: "search-icon")
			imageView.contentMode = .scaleAspectFit
			self.leftView = imageView;
			self.leftViewMode = .always
			
		}
		if (rightIcon){
			let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
			imageView.image = #imageLiteral(resourceName: "edit_icn")
			self.rightView = imageView;
			self.rightViewMode = .always
		}
	}
}
