//
//  Extension+UIApplication.swift
//  AmicoLive
//
//  Created by Invision on 18/12/2018.
//  Copyright © 2018 Invision. All rights reserved.
//
import UIKit
import JGProgressHUD
import Foundation
extension UIApplication{
	//Show hide loader.
	class func startActivityIndicator(with message: String? = "") {
		let hud = JGProgressHUD(style: .dark)
		hud.tag = 999
		hud.textLabel.text = message
		if let view = self.shared.keyWindow {
			hud.show(in: view)
		}
	}
	
	class func stopActivityIndicator(){
		if let hud = self.shared.keyWindow?.viewWithTag(999) as? JGProgressHUD {
			hud.dismiss()
			hud.removeFromSuperview()
		}
	}
}
