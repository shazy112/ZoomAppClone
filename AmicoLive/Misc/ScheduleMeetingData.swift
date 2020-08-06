import UIKit
import MobileRTC
struct ScheduleMeetingData {
	var topic:String?
	var startTime:Date?
	var duration:UInt?
	var timezone:String?
	var meetingType:MeetingType?
	var zoomMeetingType:MeetingRepeat?
	var pmi:Bool?
	var hostVideoOff:Bool?
	var attendeeVideoOff:Bool?
	var password:String?
	var audioType:AudioType?
	var zoomAudioType:MobileRTCMeetingItemAudioType?
	
	init(formValues:[String:Any?]) {
		topic = formValues["Topic"] as? String
		startTime = formValues["Starts"] as? Date
		var dur = formValues["Duration"] as? String
		dur = dur?.replacingOccurrences(of: " min", with: "")
		duration = UInt(dur ?? "0")
		timezone = formValues["Timezone"] as? String
		let meetType = formValues["Repeat"] as? String
		meetingType = MeetingType.init(rawValue:meetType ?? "Never" )
		zoomMeetingType = MeetingRepeat.init(rawValue: (meetingType?.value())!)
		pmi = formValues["PMI"] as? Bool
		hostVideoOff = formValues["HostVideo"] as? Bool
		attendeeVideoOff = formValues["ParticipantVideo"] as? Bool
		password = formValues["Password"] as? String
		audioType = AudioType.init(rawValue: formValues["AudioOptions"] as? String ?? "")
		zoomAudioType = MobileRTCMeetingItemAudioType.init(rawValue: (audioType?.value())!)
	}
}
