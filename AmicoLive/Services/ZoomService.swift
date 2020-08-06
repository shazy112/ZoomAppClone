//
//  ZoomService.swift
//  AmicoLive
//
//  Created by Invision on 28/11/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import UIKit
import MobileRTC



class ZoomService: NSObject {
	
	class func setup(){
		MobileRTC.shared().setMobileRTCDomain("zoom.us")
	}
	
	class func performSDKAuth(delegate:MobileRTCAuthDelegate){
		setup()
		if let authService = MobileRTC.shared()?.getAuthService()
		{
			authService.delegate = delegate
			authService.clientKey = Constants.Zoom.SDKKey
			authService.clientSecret = Constants.Zoom.SDKSecret
			let acountinfo = authService.getAccountInfo()
			authService.sdkAuth()
			
		}
	}
	
	class func login(delegate:MobileRTCAuthDelegate,with email:String, password:String, rememberMe:Bool){
		if let authService = MobileRTC.shared().getAuthService(){
			authService.delegate = delegate
			authService.login(withEmail: email, password: password, remeberMe: rememberMe)
		}
	}
	
	class func startMeeting(noVideo:Bool, delegate:MobileRTCMeetingServiceDelegate){
		if let meetingService = MobileRTC.shared().getMeetingService(){
			meetingService.delegate = delegate
			let param = MobileRTCMeetingStartParam()
			param.isAppShare = false
			param.noVideo = noVideo
			meetingService.startMeeting(with: param)
		}
	}
	
	class func editMeeting(delegate:MobileRTCPremeetingDelegate,meeting:MeetingItemData,formData:ScheduleMeetingData){
		
		
		if let preMeetingService = MobileRTC.shared().getPreMeetingService(), let meetingItem = preMeetingService.getMeetingItem(byUniquedID: meeting.meetingid!)
		{
			
			//preMeetingService.listMeeting()
			preMeetingService.delegate = delegate
			//			meetingItem.setMeetingTopic(formData.topic ?? "Personal Meeting room")
			//			meetingItem.setStartTime(formData.startTime ?? Date())
			//			meetingItem.setDurationInMinutes(formData.duration ?? 0)
			//			meetingItem.setTimeZoneID(formData.timezone ?? "America/Toronto")
			//			meetingItem.setMeetingRepeat(formData.zoomMeetingType!)
			//			meetingItem.setUsePMIAsMeetingID(formData.pmi ?? false)
			meetingItem.turnOffVideo(forHost: formData.hostVideoOff ?? false)
			meetingItem.turnOffVideo(forAttendee: formData.attendeeVideoOff ?? false)
			meetingItem.setAudioOption(formData.zoomAudioType ?? MobileRTCMeetingItemAudioType(rawValue: 0)!)
			if let password = formData.password{
				meetingItem.setMeetingPassword(password)
			}
			preMeetingService.editMeeting(meetingItem)
		}
	}
	
	
	class func scheduleMeeting(delegate:MobileRTCPremeetingDelegate, topic:String, startTime:Date, duration:UInt, timezoneID:String, meetingRepeat:MeetingRepeat, usePMI:Bool, hostVideoOff:Bool, attendeeVideoOff:Bool, audioOption:MobileRTCMeetingItemAudioType, password:String?){
		
		
		if let preMeetingService = MobileRTC.shared().getPreMeetingService(), let meetingItem = preMeetingService.createMeetingItem()
		{
			//preMeetingService.listMeeting()
			preMeetingService.delegate = delegate
			meetingItem.setMeetingTopic(topic)
			meetingItem.setStartTime(startTime)
			meetingItem.setDurationInMinutes(duration)
			meetingItem.setTimeZoneID(timezoneID)
			meetingItem.setMeetingRepeat(meetingRepeat)
			meetingItem.setUsePMIAsMeetingID(usePMI)
			meetingItem.turnOffVideo(forHost: hostVideoOff)
			meetingItem.turnOffVideo(forAttendee: attendeeVideoOff)
			meetingItem.setAudioOption(audioOption)
			if let password = password{
				meetingItem.setMeetingPassword(password)
			}
			preMeetingService.scheduleMeeting(meetingItem, withScheduleFor: nil)
			
		}
	}
	
	class func joinMeeting(delegate:MobileRTCMeetingServiceDelegate,meetingId:String,meetingPassword:String?,audio:Bool,video:Bool){
		if let meetingService = MobileRTC.shared().getMeetingService(){
			meetingService.delegate = delegate
		let paramDict = [kMeetingParam_Username: "", kMeetingParam_MeetingNumber: meetingId,kMeetingParam_MeetingPassword:meetingPassword ?? "",kMeetingParam_NoAudio:audio,kMeetingParam_NoVideo:video] as [String : Any] //as [String : Any]
			let ret: MobileRTCMeetError = meetingService.joinMeeting(with: paramDict)
		}
	}
	
	class func getScheduledMeetings(delegate:MobileRTCPremeetingDelegate){
		if let preMeetingService = MobileRTC.shared().getPreMeetingService() {
			preMeetingService.delegate = delegate
			preMeetingService.listMeeting()
		}
	}
	
	class func startMeeting(delegate:MobileRTCMeetingServiceDelegate,meetingNumber:String = "",video:Bool){
		if let meetingService = MobileRTC.shared().getMeetingService() {
			let user = MobileRTCMeetingStartParam4LoginlUser()
			//MobileRTC.shared()?.getMeetingSettings()?.meetingInviteHidden = true
			let param:MobileRTCMeetingStartParam = user
			if meetingNumber.isEmpty == false{
				param.meetingNumber = meetingNumber}
			meetingService.delegate = delegate
			param.noVideo = !video
			//param.meetingNumber = ""
			let ret: MobileRTCMeetError = meetingService.startMeeting(with: param)
			
			print(ret)
		}
	}
	class func customizedEmail(){
		var inviteLink : String = ""
		guard let meetingNum = MobileRTCInviteHelper.sharedInstance()?.ongoingMeetingNumber else {return}
		let pwd = MobileRTCInviteHelper.sharedInstance()?.rawMeetingPassword
		if pwd?.isEmpty == false{
			inviteLink =  "Please join Amico Live \n https://live.amico.com/?id=\(meetingNum) \n Password \(pwd!)"}
		else {
			inviteLink = "Please join Amico Live \n https://live.amico.com/?id=\(meetingNum)"
		}
		MobileRTCInviteHelper.sharedInstance().inviteEmailSubject = "Please join Amico Live Meeting in progress"
		MobileRTCInviteHelper.sharedInstance().inviteEmailContent = inviteLink
		MobileRTCInviteHelper.sharedInstance()?.inviteSMS = inviteLink
		MobileRTCInviteHelper.sharedInstance()?.inviteCopyURL = inviteLink
		
	}
}
