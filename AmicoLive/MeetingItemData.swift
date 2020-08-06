//
//  MeetingItemData.swift
//  AmicoLive
//
//  Created by Invision on 31/12/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import Foundation
import MobileRTC
struct MeetingItemData {
	var meetingid:UInt64?
	var topic:String?
	var startTime:Date?
	var duration:UInt?
	var timezone:String?
	var meetingType:EditMeetingType?
	var pmi:Bool?
	var hostVideoOff:Bool?
	var attendeeVideoOff:Bool?
	var password:String?
	var audioType:EditAudioType?
	
	var zoomAudioType:MobileRTCMeetingItemAudioType?
	var zoomMeetingType:MeetingRepeat?
	
	
	init(meeting:MobileRTCMeetingItem) {
		meetingid = meeting.getMeetingUniquedID()
		topic = meeting.getMeetingTopic()
		startTime = meeting.getStartTime()?.convertToAppDateFormat
		duration = meeting.getDurationInMinutes()
		timezone = meeting.getTimeZoneID()
		meetingType = EditMeetingType(rawValue: meeting.getMeetingRepeat().rawValue)
		pmi = meeting.isPersonalMeeting()
		hostVideoOff = meeting.isHostVideoOff()
		attendeeVideoOff = meeting.isAttendeeVideoOff()
		password = meeting.getMeetingPassword()
		audioType = EditAudioType(rawValue: meeting.getAduioOption().rawValue)
		
		zoomAudioType = MobileRTCMeetingItemAudioType.init(rawValue: (meeting.getAduioOption().rawValue))
		zoomMeetingType = MeetingRepeat.init(rawValue: (meeting.getMeetingRepeat().rawValue))
	}
}
