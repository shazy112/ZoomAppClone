//
//  Extension+UITextfield.swift
//  AmicoLive
//
//  Created by Invision on 18/12/2018.
//  Copyright © 2018 Invision. All rights reserved.
//
import UIKit
import Foundation
extension UITextField{
	
	func shakeIfEmpty() {
		let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
		animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
		animation.duration = 0.6
		animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
		layer.add(animation, forKey: "shake")
		layer.borderWidth = 1.0
		layer.borderColor = UIColor.red.cgColor
		
	}
}
