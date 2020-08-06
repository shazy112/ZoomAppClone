//
//  AddContactViewController.swift
//  AmicoLive
//
//  Created by Invision on 09/01/2019.
//  Copyright © 2019 Invision. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController,CheckEmailDelegate {
	lazy var checkEmailViewModel = CheckEmailViewModel(delegate: self)
	@IBOutlet weak var emailTextField: UITextField!
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	@IBAction func saveTapped(_ sender: Any) {
		if !emailTextField.text!.isEmpty{
			if emailTextField.text!.validateEmail() {
				checkEmailViewModel.checkEmailwith(email: emailTextField.text!)}
			else {
				Alert.showAlert(vc: self, message: "Please enter a valid email address") }
		}else {
			Alert.showAlert(vc: self, message: "Please enter email address")
		}
	}
	
	@IBAction func cancelTapped(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	func emailSuccess(emailExist: Bool?) {
		if let email = emailExist{
			if !email{
				Alert.showAlert(vc: self, message: "This account does not exist")
			}
			else {
				Alert.showAlert(vc: self, message: "We've sent an invitaion link to user.")
				emailTextField.text = ""
			}
		}
	}
	
	func emailFailure(msg: String) {
		Alert.showAlert(vc: self, message: msg)
	}
}
