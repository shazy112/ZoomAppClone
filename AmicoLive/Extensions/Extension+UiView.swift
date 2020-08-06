//
//  Extension+UiView.swift
//  AmicoLive
//
//  Created by Invision on 18/12/2018.
//  Copyright © 2018 Invision. All rights reserved.
//
import UIKit
import Foundation
extension UIView {
	func toggleView(hidden: Bool){
		UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {
			self.isHidden = hidden
		})
	}
}
