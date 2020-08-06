//
//  Extensions.swift
//  AmicoLive
//
//  Created by Invision on 05/12/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

extension UInt64{
	var converToString:String{
		return	String(self)
	}
}
extension UInt{
	var converToString:String{
		return	String(self)
	}
}
extension Int{
	var convertToString:String{
		return String(self)
	}
}

extension String {
		func validateEmail() -> Bool {
			let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
			let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
			return emailPredicate.evaluate(with: self)
		}
}

extension Date{
	
	var convertToAppDateFormat:Date?{
		let dateFormatterGet = DateFormatter()
		dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss z"
		let formattedDate = dateFormatterGet.string(from: self)
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd h:mm a"
		let date: Date? = dateFormatterGet.date(from: formattedDate)
		print(dateFormatter.string(from: date!))
		return date
	}
	
	
}
