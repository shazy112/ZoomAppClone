
enum MeetingType:String{
	case never = "Never"
	case everyDay = "Everyday"
	case everyWeek = "Every week"
	case every2week = "Every 2 week"
	case everyMonth = "Every Month"
	case everyYear = "Every year"
	func value()-> UInt32{
		switch self {
		case .never:
			return 0
		case .everyDay:
			return 1
		case .everyWeek:
			return 2
		case .every2week:
			return 3
		case .everyMonth:
			return 4
		case .everyYear:
			return 5
		}
	}
}
enum EditMeetingType:UInt32{
	case never = 0
	case everyDay = 1
	case everyWeek = 2
	case every2week = 3
	case everyMonth = 4
	case everyYear = 5
	var myValue:String?{
		switch self {
		case .never:
			return "Never"
		case .everyDay:
			return "Everyday"
		case .everyWeek:
			return "Every Week"
		case .every2week:
			return "Every 2 week"
		case .everyMonth:
			return "Every Month"
		case .everyYear:
			return "Every year"
		}
	}
}
