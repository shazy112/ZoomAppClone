//
//  UpcommingEventsTableViewCell.swift
//  AmicoLive
//
//  Created by Invision on 05/12/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import UIKit

class UpcommingEventsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var personmeetingTitleLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var startMeetingButton: UIButton!
	@IBOutlet weak var sendInvationButton: UIButton!
	@IBOutlet weak var personalMeetingIdLabel: UILabel!
	var meetingData:MeetingItemData?
	override func awakeFromNib() {
        super.awakeFromNib()
        //if Defaults.pmi != personalMeetingIdLabel.text?.replacingOccurrences(of: " ", with: ""){
            personmeetingTitleLabel.text = meetingData?.topic
        //}
        
        
        startMeetingButton.layer.borderWidth = 1
        startMeetingButton.layer.borderColor = #colorLiteral(red: 0.2709999979, green: 0.4550000131, blue: 0.7689999938, alpha: 1)
        startMeetingButton.layer.cornerRadius = 6
        
        sendInvationButton.layer.borderWidth = 1
        sendInvationButton.layer.borderColor = #colorLiteral(red: 0.2709999979, green: 0.4550000131, blue: 0.7689999938, alpha: 1)
        sendInvationButton.layer.cornerRadius = 6
        
        editButton.layer.borderWidth = 1
        editButton.layer.borderColor = #colorLiteral(red: 0.2709999979, green: 0.4550000131, blue: 0.7689999938, alpha: 1)
        editButton.layer.cornerRadius = 6
        // Initialization code
    }


}
