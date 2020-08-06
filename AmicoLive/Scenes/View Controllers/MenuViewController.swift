//
//  MenuViewController.swift
//  AmicoLive
//
//  Created by Invision on 28/11/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import UIKit
import MobileRTC
struct MenuOption{
	var title: String
	var image: UIImage
	var segue: String
}
class MenuViewController: UIViewController,GetUserDelegate,MobileRTCAuthDelegate {
	func onMobileRTCAuthReturn(_ returnValue: MobileRTCAuthError) {
		//
	}
	
	func failure(message: String?) {
		Alert.showAlert(vc: self, message: "Sign-in is reserved for Amico users only.") {
			self.performSegue(withIdentifier: "goToAuth", sender: self)
		}
	}
	
	func success(users: Users) {
		Defaults.pmi = users.pmi?.convertToString
		User.shared.users = users
	}
	
	var menuDataSource = MenuDataSource()
	@IBOutlet weak private var tableView: UITableView!{
		didSet{
			tableView.dataSource = menuDataSource
			tableView.delegate = self
		}}
	lazy var getUserViewModel = GetUserViewModel(delegate: self)
	let menuOptions = [MenuOption(title: "Join a Meeting", image: #imageLiteral(resourceName: "amico_live_join_a_meeting"), segue: "goToJoinAMeeting"),
					   MenuOption(title: "Start a Meeting", image: #imageLiteral(resourceName: "amico_live_start_a_meeting"), segue: "GotoStartMeeting"),
					   MenuOption(title: "Schedule a Meeting", image: #imageLiteral(resourceName: "amico_live_schedule_a_meeting"), segue: "GotoScheduleMeeting"),
					   MenuOption(title: "Upcoming Meetings", image: #imageLiteral(resourceName: "amico_live_upcoming_meetings"), segue: "GotoUpcomingMeetings"),
					   MenuOption(title: "Contacts", image: #imageLiteral(resourceName: "amico_live_contacts"), segue: "GotoContacts"),
					   MenuOption(title: "Resources", image: #imageLiteral(resourceName: "amico_live_resources"), segue: "goToResources")]
	
	override func viewDidLoad() {
		menuDataSource.menuData = menuOptions
		
		getUserViewModel.getUsers()
		let appdelegate =  UIApplication.shared.delegate as! AppDelegate
		appdelegate.meetingDelegate = self
		
	}
	
	
	
	@IBAction func logout(_ sender: Any) {
		
		if let authService = MobileRTC.shared()?.getAuthService(){
			authService.delegate = self
			Alert.confirmationAlertWithAction(yesActionMsg: "Yes", noActionMsg: "No", vc: self, message: "Are you sure you want to logout?") { (result) in
				if result == true {
					Defaults.isloggedIn = false
					authService.logoutRTC()
					
				}
			}
		}
		
	}
	func onMobileRTCLogoutReturn(_ returnValue: Int) {
		performSegue(withIdentifier: "goToAuth", sender: self)
		print(returnValue)
	}
	
}

extension MenuViewController: UITableViewDelegate{
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: menuOptions[indexPath.row].segue, sender: self)
	}}

extension MenuViewController:MeetinJoinedDelegate,MobileRTCMeetingServiceDelegate{
	func joinMeetingwith(meetingNumber: String) {
		if Defaults.isloggedIn != nil && Defaults.isloggedIn == true{
			ZoomService.joinMeeting(delegate: self, meetingId: meetingNumber, meetingPassword: "", audio: true, video: true)}
	}
	func onMeetingError(_ error: MobileRTCMeetError, message: String!) {
		if error.rawValue != 0 {
			Alert.showAlert(vc: self, message: message)
		}
	}
	
	func onMeetingStateChange(_ state: MobileRTCMeetingState) {
	}
	
	func onMeetingEndedReason(_ reason: MobileRTCMeetingEndReason) {
		UIApplication.stopActivityIndicator()
		let reasonMessage = MeetingEnded.init(rawValue: reason.rawValue)
		Alert.showAlert(vc: self, message: reasonMessage?.resultDesc() ?? "Meeting ended due to unknown reason")
		changeDeviceOrientation(deviceOrientation: .portrait, interfaceOrientation: .portrait)
	}
	
	func onJoinMeetingConfirmed() {
		UIApplication.stopActivityIndicator()
		print("True")
		changeDeviceOrientation(deviceOrientation: .all, interfaceOrientation: .portrait)
	}
}
