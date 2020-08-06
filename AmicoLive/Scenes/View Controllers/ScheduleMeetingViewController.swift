//
//  ScheduleMeetingViewController.swift
//  AmicoLive
//
//  Created by Invision on 29/11/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import UIKit
import Eureka
import MobileRTC
class ScheduleMeetingViewController: FormViewController {
	var smData :ScheduleMeetingData?
	override func viewDidLoad() {
        super.viewDidLoad()
		initializeForm()
    }
    
    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
		
		if form.validate().count == 0 {
			UIApplication.startActivityIndicator()
			let formValues = form.values()
			smData = ScheduleMeetingData(formValues: formValues)
			//Forcefully casted because these values wont be nil except meeting title.
			ZoomService.scheduleMeeting(delegate: self, topic: (smData?.topic)!, startTime: (smData?.startTime)!, duration: (smData?.duration)!, timezoneID: (smData?.timezone)!, meetingRepeat: MeetingRepeat(rawValue: (smData?.zoomMeetingType?.rawValue)!), usePMI: (smData?.pmi)!, hostVideoOff: (smData?.hostVideoOff)!, attendeeVideoOff: (smData?.attendeeVideoOff)!, audioOption: MobileRTCMeetingItemAudioType(rawValue: (smData?.zoomAudioType?.rawValue)!)!, password: smData?.password)
		}
		else {
			Alert.showAlert(vc: self, message: "Please select a meeting Topic")
		}
 }

	func initializeForm(){
		form +++
			Section{
				$0.header = HeaderFooterView<HeaderLogoView>(.class)
			}
			<<< TextRow("Topic"){
				$0.placeholder = "Meeting Topic"
				$0.add(rule: RuleRequired())
				$0.validationOptions = .validatesAlways
			}
			+++ Section()
			<<< DateTimeRow("Starts"){
				$0.title = "Starts"
				$0.value = Date()
			}
			<<< PushRow<String>("Duration"){
				$0.title = "Duration"
				$0.options = ["15 min", "30 min", "1 hour"]
				$0.value = "15 min"
			}
			<<< PushRow<String>("Timezone"){
				$0.title = "Timezone"
				$0.options = ["America/Toronto", "Asia/Japan", "Africa/Capetown"]
				$0.value = "America/Toronto"
			}
			<<< PushRow<String>("Repeat"){
				$0.title = "Repeat"
				$0.options = ["Never", "Everyday", "Every week", "Every 2 week", "Every month", "Every year"]
				$0.value = "Never"
			}
			<<< SwitchRow("PMI"){
				$0.title = "Use Personal Meeting ID"
				$0.value = false
				
			}
			+++ Section("MEETING OPTIONS")
			<<< SwitchRow("HostVideo"){
				$0.title = "Host video on when starting"
				$0.value = false
			}
			<<< SwitchRow("ParticipantVideo"){
				$0.title = "Participant video on when starting"
				$0.value = false
			}
			<<< PushRow<String>("AudioOptions"){
				$0.title = "Audio option"
				$0.options = ["Telephone", "VOIP", "Telephone and VOIP", "3rd Party Audio"]
				$0.value = "Telephone and VOIP"
			}
			<<< TextRow("Password"){ row in
				row.title = "Meeting password"
				row.placeholder = "(optional)"
		}
	}
	
	func hideLoader(_ result: PreMeetingError){
		UIApplication.stopActivityIndicator()
		let scheduleMeetingResult = ScheduledMeetingResult.init(rawValue: result.rawValue)
		Alert.showAlert(vc: self, message: scheduleMeetingResult?.resultDesc() ?? "")
		goToVc {
			self.navigationController?.popViewController(animated: true)
		}
	}
}
extension ScheduleMeetingViewController:MobileRTCPremeetingDelegate{
	func sinkSchedultMeeting(_ result: PreMeetingError, meetingUniquedID uniquedID: UInt64) {
		hideLoader(result)
	}
	
	func sinkEditMeeting(_ result: PreMeetingError, meetingUniquedID uniquedID: UInt64) {
		//UIApplication.stopActivityIndicator()
	}
	
	func sinkDeleteMeeting(_ result: PreMeetingError) {
		//UIApplication.stopActivityIndicator()
	}
	
	func sinkListMeeting(_ result: PreMeetingError, withMeetingItems array: [Any]) {
		//hideLoader(result)
	}
	
	
}





