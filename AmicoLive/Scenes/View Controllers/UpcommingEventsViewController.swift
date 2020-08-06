//
//  ScheduledMeetingsViewController.swift
//  AmicoLive
//
//  Created by Invision on 05/12/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import UIKit
import MobileRTC
import MessageUI
class UpcommingEventsViewController: UIViewController {
	
	
	@IBOutlet weak private var tableView: UITableView!{
		didSet{
			tableView.delegate = self
			tableView.dataSource = self
		}
	}
	var _meetings : [MeetingItemData] = []
	var meetings:[UInt64] = []
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let _ = User.shared.users?.pmi{
			UIApplication.startActivityIndicator()
			ZoomService.getScheduledMeetings(delegate: self)
		}
		else {
			Alert.showAlert(vc: self, message: "Sign-in is reserved for Amico users only.") {
				self.navigationController?.popViewController(animated: true)
			}}
		
	}

	func setupAction()->[(String, UIAlertActionStyle)]{
		var actions: [(String, UIAlertActionStyle)] = []
		actions.append(("Send Message", UIAlertActionStyle.default))
		actions.append(("Send Email", UIAlertActionStyle.default))
		actions.append(("Cancel", UIAlertActionStyle.cancel))
		return actions
	}
	
	@objc func editMeeting(sender:UIButton){
		let index = sender.tag
		let meetingToSend = _meetings[index]
		performSegue(withIdentifier: "goToEditMeetingVc", sender: meetingToSend)
	}
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let vc = segue.destination as? EditMeetingViewController {
			let _meetingToSend = sender as? MeetingItemData
			vc.meetings = _meetingToSend
		}
	}
	
	@objc func startMeeting(sender:UIButton){
		let index = sender.tag
		let meetingNum = meetings[index].converToString
		Alert.confirmationAlertWithAction(yesActionMsg: "Yes", noActionMsg: "No", vc: self, message: "Are you sure you want to start this meeting?") { (result) in
			switch result{
			case true:
				UIApplication.startActivityIndicator()
				ZoomService.startMeeting(delegate: self, meetingNumber: meetingNum,video:true)
			case false:
				print("Canceled")
			}
		}
	}
	
	@objc func sendInvationTapped(sender:UIButton){
		let index = sender.tag
		var invitationLink : String = ""
		if let pwd =  _meetings[index].password{
			invitationLink = getLink(withMeetingId: meetings[index].converToString, password: pwd)}else {
			invitationLink = getLink(withMeetingId: meetings[index].converToString)
		}
		Alert.showActionsheet(vc: self, message: "Select to send invitation", actions: setupAction()) { (index) in
			switch index{
			case 0:
				self.sendMessage(withMessage: invitationLink, delegate: self)
			case 1:
				self.sendEmailWith(delegate: self, subject: "Please join the ongoing meeting", body: invitationLink)
			default:
				print("Default")
			}
		}
	}
	func assignTag(sender:[UIButton],tag:Int){
		_ = sender.compactMap{$0.tag = tag}
	}
	
}
extension UpcommingEventsViewController:MobileRTCPremeetingDelegate  {
	func sinkSchedultMeeting(_ result: PreMeetingError, meetingUniquedID uniquedID: UInt64) {
		print(result.rawValue)
	}
	
	func sinkEditMeeting(_ result: PreMeetingError, meetingUniquedID uniquedID: UInt64) {
	}
	
	func sinkDeleteMeeting(_ result: PreMeetingError) {
	}
	
	
	
	func sinkListMeeting(_ result: PreMeetingError, withMeetingItems array: [Any]) {
		if let meetingData = array as? [MobileRTCMeetingItem]{
			if meetingData.count > 0 {
				meetings = meetingData.compactMap{$0.getMeetingNumber()}
				_meetings = meetingData.compactMap{MeetingItemData.init(meeting: $0)}
				UIApplication.stopActivityIndicator()
				tableView.reloadData()}
		}
	}
}
extension UpcommingEventsViewController : UITableViewDelegate,UITableViewDataSource {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! UpcommingEventsTableViewCell
		assignTag(sender: [cell.sendInvationButton,cell.startMeetingButton,cell.editButton], tag: indexPath.row)
		cell.sendInvationButton.addTarget(self, action: #selector(sendInvationTapped), for: .touchUpInside)
		cell.startMeetingButton.addTarget(self, action: #selector(startMeeting), for: .touchUpInside)
		cell.editButton.addTarget(self, action: #selector(editMeeting), for: .touchUpInside)
		cell.personalMeetingIdLabel.text = meetings[indexPath.row].converToString
		if Defaults.pmi != _meetings[indexPath.row].meetingid?.converToString{
			cell.personmeetingTitleLabel.text = _meetings[indexPath.row].topic}
		else {
			cell.personmeetingTitleLabel.text = "Personal Meeting Id"
		}
		return cell
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return meetings.count
	}
	
}
extension UpcommingEventsViewController : MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate {
	func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
		dismiss(animated: true, completion: nil)
	}
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
		dismiss(animated: true, completion: nil)
	}
	
}
extension UpcommingEventsViewController:MobileRTCMeetingServiceDelegate {
	
	func onMeetingError(_ error: MobileRTCMeetError, message: String!) {
		UIApplication.stopActivityIndicator()
		
		if error.rawValue != 0 {
			Alert.showAlert(vc: self, message: message)
			
		}
	}
	
	func onMeetingEndedReason(_ reason: MobileRTCMeetingEndReason) {
		let reasonMessage = MeetingEnded.init(rawValue: reason.rawValue)
		Alert.showAlert(vc: self, message: reasonMessage?.resultDesc() ?? "Meeting ended due to unknown reason")
	}
	
	func onMeetingStateChange(_ state: MobileRTCMeetingState) {
		UIApplication.stopActivityIndicator()
		if state.rawValue == 2{
			ZoomService.customizedEmail()
		}
	}
	
	
	func onJoinMeetingConfirmed() {
		print("True")
	}
	
	func onMeetingReady() {
		//
	}
}
