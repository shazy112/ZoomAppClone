//
//  Alert.swift
//  AmicoLive
//
//  Created by Invision on 11/12/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import Foundation
import UIKit
class Alert {
	class func confirmationAlertWithAction(yesActionMsg:String,noActionMsg:String,vc:UIViewController,message:String,completion:@escaping(_ result:Bool)->()){
		let confirmationAlert = UIAlertController(title: message, message: "", preferredStyle: .alert)
		// Create the actions
		let okAction = UIAlertAction(title: yesActionMsg, style: UIAlertActionStyle.default) {
			UIAlertAction in
			completion(true)
		}
		let cancelAction = UIAlertAction(title: noActionMsg, style: UIAlertActionStyle.cancel) {
			UIAlertAction in
			completion(false)
		}
		
		// Add the actions
		
		confirmationAlert.addAction(cancelAction)
		confirmationAlert.addAction(okAction)
		vc.present(confirmationAlert, animated: true, completion: nil)
	}
	
	//Show Alert with just a particular message
	class func showAlert(vc:UIViewController,message:String){
		let confirmationAlert = UIAlertController(title: message, message: "", preferredStyle: .alert)
		let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
		confirmationAlert.addAction(okAction)
		vc.present(confirmationAlert, animated: true, completion: nil)
	}
	
	class func showAlert(vc:UIViewController,message:String,completion:@escaping ()->()){
		let confirmationAlert = UIAlertController(title: message, message: "", preferredStyle: .alert)
		let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
			completion()
		}
		confirmationAlert.addAction(okAction)
		vc.present(confirmationAlert, animated: true, completion: nil)
	}
	
	
	//Pressent Action sheet with completion
	class func showActionsheet(vc:UIViewController, message: String, actions: [(String, UIAlertActionStyle)], completion: @escaping (_ index: Int) -> Void) {
		let alertViewController = UIAlertController(title: message, message: "", preferredStyle: .actionSheet)
		for (index, (title, style)) in actions.enumerated() {
			let alertAction = UIAlertAction(title: title, style: style) { (_) in
				completion(index)
			}
			alertViewController.addAction(alertAction)
		}
		vc.present(alertViewController, animated: true, completion: nil)
	}
	
	
}
