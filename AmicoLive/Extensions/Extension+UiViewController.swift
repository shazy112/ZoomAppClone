//
//  Extension+UiViewController.swift
//  AmicoLive
//
//  Created by Invision on 18/12/2018.
//  Copyright © 2018 Invision. All rights reserved.
//
import UIKit
import Foundation
import Presentr
extension UIViewController{
	open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
	}
	func goToVc(completion:@escaping ()->Void){
		DispatchQueue.main.asyncAfter(deadline: .now()+1) {
			completion()
		}
	}
	
	func showPopUp(withIdentifier:String,height:Float)->UIViewController{
		let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewController(withIdentifier: withIdentifier)
		let presentr:Presentr = Presentr(presentationType: .custom(width: .custom(size: Float(self.view.frame.width - 40)), height: .custom(size: height), center: .center))
		presentr.roundCorners = true
		customPresentViewController(presentr, viewController: vc, animated: true)
		return vc
	}
	
	func changeDeviceOrientation(deviceOrientation:UIInterfaceOrientationMask,interfaceOrientation:UIInterfaceOrientation){
		appDelegate.deviceOrientation = deviceOrientation
		let value = interfaceOrientation.rawValue
		UIDevice.current.setValue(value, forKey: "orientation")
	}
}
	

