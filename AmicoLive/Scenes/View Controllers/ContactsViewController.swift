//
//  ContactsViewController.swift
//  AmicoLive
//
//  Created by Invision on 17/12/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import UIKit
import MultiContactPicker
import Contacts
import MessageUI
class ContactsViewController: UIViewController {
	
	@IBOutlet weak private var optionsView: UIView!
	@IBOutlet weak private var contactOptionsView: UIView!
	lazy var listUserViewModel = ListUserViewModel(delegate: self)
    var listUsers:[Users] = []
	let options = ["Add a Contact","Create a New Group","Join a Public Group"]
	@IBOutlet weak var contactOptionsTableView: UITableView!{
		didSet{
			contactOptionsTableView.dataSource = self }
	}
    @IBOutlet weak var contactsTableView: UITableView!{
        didSet{
            contactsTableView.delegate = self
            contactsTableView.dataSource = self
        }
    }
    @IBOutlet weak private var addContactsButton: UIButton!
	override func viewDidLoad() {
		super.viewDidLoad()
		contactOptionsView.isHidden = true
		viewTapped()
		listUserViewModel.listUserer()
		// Do any additional setup after loading the view.
	}
    
    @IBAction func showOptions(_ sender: Any) {
        contactOptionsView.toggleView(hidden: false)
    }
    
	@IBAction func showContactList(_ sender: Any) {
		MultiContactPicker.shared.openContacts(controller: self)
	}
	
	func viewTapped(){
		let tap = UITapGestureRecognizer(target: self, action: #selector(contactsOptionViewTapped))
		contactOptionsView.addGestureRecognizer(tap)
	}
	
	@objc func contactsOptionViewTapped(){
		contactOptionsView.toggleView(hidden: true)
	}
    
	@objc func settingOptionTapped(sender:UIButton){
		switch sender.tag {
		case 0:
			print("Working fine.")
            showPopUp(withIdentifier: "AddContactViewController", height: 250)
		default:
			print("Default")
		}
	}
	
}

extension ContactsViewController:ListUserDelegaete{
	func success(users: ListUsers) {
		print(users)
		for i in users.users ?? []{
				listUsers.append(i)
		}
        contactsTableView.reloadData()
	}
	
	func failure(message: String?) {
		print(message ?? "Nil")
	}
}

extension ContactsViewController : UITableViewDataSource,UITableViewDelegate {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        switch tableView {
        case contactsTableView:
             let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ContactsTableViewCell
             let username = "\(listUsers[index].firstName ?? "") \(listUsers[index].lastName ?? "")"
             cell.name = username
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! AddContactsTableViewCell
            cell.title = options[indexPath.row]
            cell.titleButton.tag = indexPath.row
            cell.titleButton.addTarget(self, action: #selector(settingOptionTapped), for: .touchUpInside)
            return cell
        }
		
	}
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if  listUsers.count > 1 {
        if indexPath.row == listUsers.count - 1 {
            listUserViewModel.listUserer()
            }}
    }
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch tableView {
		case contactsTableView:
			return listUsers.count 
		default:
			return options.count
		}
		
	}
}

extension ContactsViewController:MultiContactPickerProtocol,MFMessageComposeViewControllerDelegate {
	func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
		dismiss(animated: true, completion: nil)
	}
	
	func selectedContacts(cNContact: [CNContact]) {
		
		let contacts = Contacts.getPhoneNumbers(cNContact: cNContact)
		//Added a 1 sec interval so that the cncontact vc get dismissed and we can again pressen our msgVc with a 1 sec break.
		DispatchQueue.main.asyncAfter(deadline: .now()+1) {
			self.sendMessage(withMessage: Constants.invitationLink, delegate: self,recipents:contacts)
		}
		
	}
}

