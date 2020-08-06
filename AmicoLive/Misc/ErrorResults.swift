enum AuthResult:UInt32 {
		case failure = 1
		case success = 0
		
		func desc()->Bool{
			switch self {
			case .failure:
				return false
			case .success:
				return true
			}
		}
	}
	
enum ScheduledMeetingResult:Int32 {
		case failure = 1
		case success = 0
		
		func resultDesc()->String{
			switch self {
			case .failure:
				return "Cant not schedule meeting at this time"
			case .success:
				return "Meeting successfully scheduled"
			}
		}
	}

enum JoinMeetingResult:UInt32 {
	case failure = 1
	case success = 0
	
	func resultDesc()->String{
		switch self {
		case .failure:
			return "Cant not join meeting at this time"
		case .success:
			return "Meeting joined successfully"
		}
	}
}

enum LoginResult:Int {
	case failure = 1
	case success = 0
	
	func resultDesc()->Bool{
		switch self {
		case .failure:
			return false
		case .success:
			return true
		}
	}
}
enum MeetingEnded:UInt32 {
	
	case credentialsInfoForJoinMeeting = 0
	case mobileRTCMeetingEndReasonRemovedByHost = 1
	case mobileRTCMeetingEndReasonEndByHost = 2
	case mobileRTCMeetingEndReasonJBHTimeout = 3
	case mobileRTCMeetingEndReasonfreeMeetingTimeout = 4
	case mobileRTCMeetingEndReasonHostEndForAnotherMeeting = 6
	case mobileRTCMeetingEndReasonConnectBroken = 7
	
	func resultDesc()->String{
		switch self {
		case .credentialsInfoForJoinMeeting:
			return "You left the meeting"
		case .mobileRTCMeetingEndReasonRemovedByHost:
			return "Meeting ended by the host"
		case .mobileRTCMeetingEndReasonEndByHost:
			return "Meeting ended by the host"
		case .mobileRTCMeetingEndReasonJBHTimeout:
			return "Joining meeting before host timeout"
		case .mobileRTCMeetingEndReasonfreeMeetingTimeout:
			return "free meeting ended by timeout"
		case .mobileRTCMeetingEndReasonHostEndForAnotherMeeting:
			return "Host ended the meeting for another meeting"
		case .mobileRTCMeetingEndReasonConnectBroken:
			return "Meeting ended due to broken connection"
		default:
			return "Meeting ended due to unknown reason"
		}
	}
}
