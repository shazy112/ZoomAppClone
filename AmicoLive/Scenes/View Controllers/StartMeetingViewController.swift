//
//  StartMeetingViewController.swift
//  AmicoLive
//
//  Created by Invision on 07/12/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import UIKit
import MobileRTC
class StartMeetingViewController: UIViewController,MobileRTCMeetingServiceDelegate {

    @IBOutlet weak var pmiSwitch: UISwitch!
    @IBOutlet weak var pmi: UILabel!
    @IBOutlet weak var videoSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
		if let _pmi = User.shared.users?.pmi{
			pmi.text = _pmi.convertToString
		}
		else {
		Alert.showAlert(vc: self, message: "This user is not added in Amico's Team. Please contact your admin.") {
			self.navigationController?.popViewController(animated: true)
			}}
		
        // Do any additional setup after loading the view.
    }
	
	
	func onMeetingError(_ error: MobileRTCMeetError, message: String!) {
		UIApplication.stopActivityIndicator()
		print(error.rawValue)
	}
	
	func onMeetingStateChange(_ state: MobileRTCMeetingState) {
		//UIApplication.stopActivityIndicator()
		if state.rawValue == 2{
			ZoomService.customizedEmail()
		}
	}
	
	
	
	func onJoinMeetingConfirmed() {
		UIApplication.stopActivityIndicator()
		print("True")
		changeDeviceOrientation(deviceOrientation: .all, interfaceOrientation: .portrait)
	}
	
	func onMeetingReady() {
		UIApplication.stopActivityIndicator()
	}

    @IBAction func startMeetingTapped(_ sender: Any) {
		pmiSwitch.isOn ? ZoomService.startMeeting(delegate: self,meetingNumber:pmi.text! ,video: videoSwitch.isOn) : ZoomService.startMeeting(delegate: self ,video: videoSwitch.isOn)
	}
	
	func onMeetingEndedReason(_ reason: MobileRTCMeetingEndReason) {
		UIApplication.stopActivityIndicator()
		let reasonMessage = MeetingEnded.init(rawValue: reason.rawValue)
		Alert.showAlert(vc: self, message: reasonMessage?.resultDesc() ?? "Meeting ended due to unknown reason")
		changeDeviceOrientation(deviceOrientation: .portrait, interfaceOrientation: .portrait)
	}
	
}
