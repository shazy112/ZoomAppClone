//
//  HomeViewController.swift
//  AmicoLive
//
//  Created by Invision on 01/02/2019.
//  Copyright © 2019 Invision. All rights reserved.
//

import UIKit
import MobileRTC
class HomeViewController: UIViewController,MobileRTCMeetingServiceDelegate {
	
    override func viewDidLoad() {
        super.viewDidLoad()
		let appdelegate =  UIApplication.shared.delegate as! AppDelegate
		appdelegate.meetingDelegate = self
	}
	
	func onMeetingError(_ error: MobileRTCMeetError, message: String!) {
		UIApplication.stopActivityIndicator()
		if error.rawValue != 0 {
			Alert.showAlert(vc: self, message: message)
		}
	}
	
	func onMeetingStateChange(_ state: MobileRTCMeetingState) {
		UIApplication.stopActivityIndicator()
	}
}
extension HomeViewController:MeetinJoinedDelegate{
	func joinMeetingwith(meetingNumber: String) {
		if Defaults.isloggedIn == nil || Defaults.isloggedIn == false {
			ZoomService.joinMeeting(delegate: self, meetingId: meetingNumber, meetingPassword: "", audio: true, video: true) 
		}}
	
}
