//
//  Extension+UIScrollView.swift
//  AmicoLive
//
//  Created by Invision on 18/12/2018.
//  Copyright © 2018 Invision. All rights reserved.
//
import UIKit
import Foundation
extension UIScrollView {
	
	override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.next?.touchesBegan(touches, with: event)
	}
}
