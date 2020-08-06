//
//  CustomSplashViewController.swift
//  AmicoLive
//
//  Created by Invision on 10/12/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import UIKit
import MobileRTC
class CustomSplashViewController: UIViewController {
	let window = UIApplication.shared.keyWindow
	var meetingId:String = ""
	override func viewDidLoad() {
		super.viewDidLoad()
		ZoomService.performSDKAuth(delegate: self)
	}
	
	func checkIfUserIsLoggedIn(){
		//If user is authenticated will return true elase if will return nil
		
		let mainstoryboard = UIStoryboard.init(name: "Main", bundle: nil)
		let navVc:UINavigationController?
		if Defaults.isloggedIn == true{
			navVc = mainstoryboard.instantiateViewController(withIdentifier: Constants.vcIdentifiers.mainNavController) as? UINavigationController
		}
		else {
			navVc = mainstoryboard.instantiateViewController(withIdentifier: Constants.vcIdentifiers.signinViewController) as? UINavigationController 
		}
		RouteManager.shared.show(vc: navVc!)
	//	self.present(navVc!, animated: true, completion: nil)
	}
}
extension CustomSplashViewController:MobileRTCAuthDelegate {
	func onMobileRTCAuthReturn(_ returnValue: MobileRTCAuthError) {
		//Check if the user is autheticted than proceed further else stop right away.
		let result = AuthResult(rawValue: returnValue.rawValue)
		if let _ = result{
			checkIfUserIsLoggedIn()
		}
		else {
			Alert.confirmationAlertWithAction(yesActionMsg: "Retry", noActionMsg: "Cancel", vc: self, message: "SDK not responding.") { (result) in
				result == true ? ZoomService.performSDKAuth(delegate: self) : nil
				
			}
		}
	}
}
