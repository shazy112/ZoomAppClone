//
//  MessageManager.swift
//  AmicoLive
//
//  Created by Invision on 07/12/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import Foundation
import UIKit
import MessageUI
extension UIViewController {
	func sendMessage(withMessage:String,delegate:MFMessageComposeViewControllerDelegate,recipents:[String]=[]){
		if MFMessageComposeViewController.canSendText() {
			
			let mc = MFMessageComposeViewController()
			mc.body = withMessage
			mc.messageComposeDelegate = delegate
			mc.recipients = recipents
			self.present(mc, animated: true, completion: nil)
		}
	}

	func sendEmailWith(delegate:MFMailComposeViewControllerDelegate,subject:String,body:String){
		if MFMailComposeViewController.canSendMail() {
		let mc: MFMailComposeViewController = MFMailComposeViewController()
		mc.mailComposeDelegate = delegate
		mc.setSubject(subject)
		mc.setMessageBody(body, isHTML: false)
		self.present(mc, animated: true, completion: nil)}
	}
	func getLink(withMeetingId:String,password:String? = nil)->String{
		if password?.isEmpty == false{
			return "Please join Amico Live \n https://live.amico.com/?id=\(withMeetingId) \n Password \(password!)"}
		else {
			return "Please join Amico Live \n https://live.amico.com/?id=\(withMeetingId)"
		}
	}
}
