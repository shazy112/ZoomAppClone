//
//  JoinAMeetingViewController.swift
//  AmicoLive
//
//  Created by Invision on 04/12/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import UIKit
import MobileRTC
class JoinAMeetingViewController: UIViewController,MobileRTCMeetingServiceDelegate {
    
    @IBOutlet weak var videoSwitch: UISwitch!
    @IBOutlet weak private var meetingIdTextField: UITextField!
    @IBOutlet weak var audioSwitch: UISwitch!
   // @IBOutlet weak private var passwordTextField: UITextField!
	//var contactsfetch = Contacts()
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    @IBAction func joinTapped(_ sender: Any) {
		if meetingIdTextField.text?.isEmpty == false{
		//UIApplication.startActivityIndicator()
			ZoomService.joinMeeting(delegate: self, meetingId: meetingIdTextField.text!, meetingPassword: "", audio: audioSwitch.isOn, video: videoSwitch.isOn)}
		else {
			Alert.showAlert(vc: self, message: "Please enter meeting id")
		}
    }
    
}
extension JoinAMeetingViewController:MeetinJoinedDelegate {
	func joinMeetingwith(meetingNumber: String) {
		ZoomService.joinMeeting(delegate: self, meetingId: meetingNumber, meetingPassword: "", audio: true, video: true)
	}
	
	
    func onMeetingError(_ error: MobileRTCMeetError, message: String!) {
		UIApplication.stopActivityIndicator()
		
		if error.rawValue != 0 {
		Alert.showAlert(vc: self, message: message)
		
		}
	}
	func onMeetingEndedReason(_ reason: MobileRTCMeetingEndReason) {
		UIApplication.stopActivityIndicator()
		let reasonMessage = MeetingEnded.init(rawValue: reason.rawValue)
		Alert.showAlert(vc: self, message: reasonMessage?.resultDesc() ?? "Meeting ended due to unknown reason")
		changeDeviceOrientation(deviceOrientation: .portrait, interfaceOrientation: .portrait)
	}
	
    func onMeetingStateChange(_ state: MobileRTCMeetingState) {
		self.view.endEditing(true)
		UIApplication.stopActivityIndicator()
	}
	
	func onJoinMeetingConfirmed() {
		UIApplication.stopActivityIndicator()
		print("True")
		changeDeviceOrientation(deviceOrientation: .all, interfaceOrientation: .portrait)
	}
	
	func onMeetingReady() {
		UIApplication.stopActivityIndicator()
	}
}
