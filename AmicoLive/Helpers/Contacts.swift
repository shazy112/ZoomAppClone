////
////  Contacts.swift
////  AmicoLive
////
////  Created by Invision on 18/12/2018.
////  Copyright © 2018 Invision. All rights reserved.
////
//
import Foundation
import MessageUI
import Contacts
class Contacts {
	class func getPhoneNumbers(cNContact:[CNContact])->[String]{
		var recipents : [String] = []
		cNContact.forEach { (contact) in
			for data in contact.phoneNumbers {
				let phoneNo = data.value
				recipents.append(phoneNo.stringValue)
			}
		}
		return recipents
	}
}
