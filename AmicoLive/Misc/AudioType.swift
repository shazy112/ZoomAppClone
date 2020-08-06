

enum AudioType:String{
	case telephone = "Telephone"
	case voip = "VOIP"
	case telephoneAndVoip = "Telephone and VOIP"
	case thirdPartyAudio = "3rd Party Audio"
	
	func value()-> UInt{
		switch self {
		case .telephone:
			return 1
		case .voip:
			return 2
		case .telephoneAndVoip:
			return 3
		case .thirdPartyAudio:
			return 4
		}
	}
}

enum EditAudioType:UInt{
	case telephone = 1
	case voip = 2
	case telephoneAndVoip = 3
	case thirdPartyAudio = 4
	
	var val:String?{
		switch self {
		case .telephone:
			return "Telephone"
		case .voip:
			return "VOIP"
		case .telephoneAndVoip:
			return "Telephone and VOIP"
		case .thirdPartyAudio:
			return "3rd Party Audio"
		}
	}
}
