//
//  SignInViewController.swift
//  AmicoLive
//
//  Created by Invision on 04/12/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import UIKit
import MobileRTC
class SignInViewController: UIViewController
{
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
	let tfValidator = TextfieldValidator()
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.tag = 0
        passwordTextField.tag = 1
        emailTextField.delegate = self
        passwordTextField.delegate = self
	}
    @IBAction func signInTapped(_ sender: Any) {
		
		let tfArray : [UITextField] = [emailTextField,passwordTextField]
		if tfValidator.validate(textFields: tfArray) == false{
		UIApplication.startActivityIndicator()
		ZoomService.login(delegate: self, with: emailTextField.text!, password: passwordTextField.text!, rememberMe: true)
		}
    }
    
    
}
extension SignInViewController:MobileRTCAuthDelegate {
	func onMobileRTCAuthReturn(_ returnValue: MobileRTCAuthError) {
		UIApplication.stopActivityIndicator()
	}
	
	func onMobileRTCLoginReturn(_ returnValue: Int) {
		UIApplication.stopActivityIndicator()
		if returnValue == 0 || returnValue == 1 {
		let result = LoginResult(rawValue: returnValue)!
		switch result.resultDesc() {
		case false:
			Alert.showAlert(vc: self, message: "Cant login at this time")
		case true:
			Defaults.isloggedIn = true
			Defaults.emailId = emailTextField.text
			goToVc {
				let mainstoryboard = UIStoryboard.init(name: "Main", bundle: nil)
				let navVc = mainstoryboard.instantiateViewController(withIdentifier: Constants.vcIdentifiers.mainNavController) as? UINavigationController
				RouteManager.shared.show(vc: navVc!)
			}
		}
		}
		else {
			Alert.showAlert(vc: self, message: "Invalid credentials")
		}
	}
}
extension SignInViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
}
