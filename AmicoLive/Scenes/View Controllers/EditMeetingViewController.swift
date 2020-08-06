//
//  EditMeetingViewController.swift
//  AmicoLive
//
//  Created by Invision on 31/12/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import UIKit
import Eureka
import MobileRTC
class EditMeetingViewController: FormViewController {
	lazy var meetings : MeetingItemData? = nil
	var smData :ScheduleMeetingData?
	
	override func viewDidLoad() {
        super.viewDidLoad()
        initializeForm()
		
        // Do any additional setup after loading the view.
    }
    
    func initializeForm(){
        form +++
            Section{
                $0.header = HeaderFooterView<HeaderLogoView>(.class)
            }
//            <<< TextRow("Topic"){
//                $0.placeholder = "Meeting Topic"
//                $0.add(rule: RuleRequired())
//                $0.validationOptions = .validatesAlways
//				$0.value = meetings?.topic
//            }
//            +++ Section()
//            <<< DateTimeRow("Starts"){
//                $0.title = "Starts"
//                $0.value = meetings?.startTime
//            }
//            <<< PushRow<String>("Duration"){
//                $0.title = "Duration"
//                $0.options = ["15 min", "30 min", "1 hour"]
//				if meetings?.duration?.converToString == "30" || meetings?.duration?.converToString == "15"{
//					$0.value = "\(meetings?.duration?.converToString ?? 0.convertToString) mins"
//				}
//				else {
//					$0.value = "\(meetings?.duration?.converToString ?? 0.convertToString) hour"
//				}
//            }
//            <<< PushRow<String>("Timezone"){
//                $0.title = "Timezone"
//                $0.options = ["America/Toronto", "Asia/Japan", "Africa/Capetown"]
//                $0.value = "America/Toronto"
//            }
//            <<< PushRow<String>("Repeat"){
//                $0.title = "Repeat"
//                $0.options = ["Never", "Everyday", "Every week", "Every 2 week", "Every month", "Every year"]
//                $0.value = meetings?.meetingType?.myValue
//            }
//            <<< SwitchRow("PMI"){
//                $0.title = "Use Personal Meeting ID"
//                $0.value = meetings?.pmi
//                
//            }
            +++ Section("MEETING OPTIONS")
            <<< SwitchRow("HostVideo"){
                $0.title = "Host video on when starting"
                $0.value = meetings?.hostVideoOff
            }
            <<< SwitchRow("ParticipantVideo"){
                $0.title = "Participant video on when starting"
                $0.value = meetings?.attendeeVideoOff
            }
            <<< PushRow<String>("AudioOptions"){
                $0.title = "Audio option"
                $0.options = ["Telephone", "VOIP", "Telephone and VOIP", "3rd Party Audio"]
                $0.value = meetings?.audioType?.val
            }
            <<< TextRow("Password"){ row in
                row.title = "Meeting password"
                row.placeholder = "(optional)"
				row.value = meetings?.password
        }
    }

	@IBAction func doneTapped(_ sender: Any) {
		UIApplication.startActivityIndicator()
		let formValues = form.values()
		smData = ScheduleMeetingData(formValues: formValues)
		ZoomService.editMeeting(delegate: self,meeting: meetings!, formData: smData!)
	}
}
extension EditMeetingViewController:MobileRTCPremeetingDelegate{
	func sinkSchedultMeeting(_ result: PreMeetingError, meetingUniquedID uniquedID: UInt64) {
		UIApplication.stopActivityIndicator()
		
	}
	
	func sinkEditMeeting(_ result: PreMeetingError, meetingUniquedID uniquedID: UInt64) {
		UIApplication.stopActivityIndicator()
	}
	
	func sinkDeleteMeeting(_ result: PreMeetingError) {
		UIApplication.stopActivityIndicator()
	}
	
	func sinkListMeeting(_ result: PreMeetingError, withMeetingItems array: [Any]) {
		UIApplication.stopActivityIndicator()
		navigationController?.popToRootViewController(animated: true)
	}
	
}
