//
//  TextfieldValidator.swift
//  AmicoLive
//
//  Created by Invision on 12/12/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import Foundation
import UIKit
class TextfieldValidator :NSObject{
	
	func validate(textFields:[UITextField])->Bool{
		for i in textFields{
			i.delegate = self
			if i.text?.isEmpty == true {
				i.shakeIfEmpty()
				return true
			}
			else {
				clearAll(textfield: i)
			}
		}
		return false
	}
	
	func clearAll(textfield:UITextField){
		textfield.layer.borderWidth = 0
		textfield.layer.borderColor = UIColor.clear.cgColor
	}
}

extension TextfieldValidator:UITextFieldDelegate{
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		if (textField.text?.count)! > -1{
			clearAll(textfield: textField)
		}
		return true
	}
}
