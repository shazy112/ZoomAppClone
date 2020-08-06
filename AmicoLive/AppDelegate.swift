//
//  AppDelegate.swift
//  AmicoLive
//
//  Created by Invision on 27/11/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import UIKit
import MobileRTC

protocol MeetinJoinedDelegate:class {
	func joinMeetingwith(meetingNumber:String)
}
let appDelegate = UIApplication.shared.delegate as! AppDelegate
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	var vc:CustomSplashViewController?
	weak var meetingDelegate : MeetinJoinedDelegate?
	var deviceOrientation = UIInterfaceOrientationMask.portrait
  	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		print(TokenGenerator.generate())
		let splashStoryboard = UIStoryboard.init(name: "CustomSplashStoryboard", bundle: nil)
		  vc = splashStoryboard.instantiateViewController(withIdentifier: Constants.vcIdentifiers.customSplashViewController) as? CustomSplashViewController
			RouteManager.shared.show(vc: vc!)
		
		
		var isUniversalLinkClick: Bool = false
		if ((launchOptions?[UIApplicationLaunchOptionsKey.userActivityDictionary]) != nil) {
			let activityDictionary = launchOptions?[UIApplicationLaunchOptionsKey.userActivityDictionary] as? [AnyHashable: Any] ?? [AnyHashable: Any]()
			let activity = activityDictionary["UIApplicationLaunchOptionsUserActivityKey"] as? NSUserActivity ?? NSUserActivity()
			if activity != nil {
				isUniversalLinkClick = true
			}
		}
		if isUniversalLinkClick {
			// app opened via clicking a universal link.
		} else {
			// set the initial viewcontroller
		}
		
		
		return true
    }
	
	func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
		return deviceOrientation
	}
	
	func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
		return true
	}
	func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
		userActivity.webpageURL?.absoluteString
		userActivity.webpageURL?.query
		let params = getParamsFromQuery(query: userActivity.webpageURL?.absoluteString ?? "")
		print(params)
		if let meetingId = params.values.first{
			DispatchQueue.main.asyncAfter(deadline: .now()+2) {
				self.meetingDelegate?.joinMeetingwith(meetingNumber: meetingId)
			}
			
			}
		return true
	}
	
	func getParamsFromQuery(query: String)-> [String: String] {
		var params : [String: String] = [:]
		let kvPairs : [String] = query.components(separatedBy: "&")
		for param in  kvPairs{
			var keyValuePair : [String] = param.components(separatedBy: "?")
			keyValuePair = param.components(separatedBy: "=")
			if keyValuePair.count == 2{
				params[keyValuePair.first!] = keyValuePair.last!
				print(keyValuePair.last!)
			}
		}
		return params
	}
}


extension  AppDelegate :  MobileRTCMeetingServiceDelegate {
	func onMeetingError(_ error: MobileRTCMeetError, message: String!) {
		UIApplication.stopActivityIndicator()
//		appDelegate.deviceOrientation = .portrait
//		let value = UIInterfaceOrientationMask.portrait
//		UIDevice.current.setValue(value, forKey: "orientation")
		if error.rawValue != 0 {
			//Alert.showAlert(vc: self, message: message)
		}
	}
	
	func onMeetingStateChange(_ state: MobileRTCMeetingState) {
		UIApplication.stopActivityIndicator()
//		appDelegate.deviceOrientation = .all
//		let value = UIInterfaceOrientationMask.portrait
//		UIDevice.current.setValue(value, forKey: "orientation")
	}
}
