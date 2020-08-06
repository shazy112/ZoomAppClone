//
//  CheckEmailViewModel.swift
//  AmicoLive
//
//  Created by Invision on 09/01/2019.
//  Copyright © 2019 Invision. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

protocol CheckEmailDelegate:class {
	func emailSuccess(emailExist:Bool?)
	func emailFailure(msg:String)
}

class CheckEmailViewModel{
	weak var delegate:CheckEmailDelegate?
	init(delegate:CheckEmailDelegate) {
		self.delegate = delegate
	}
	func checkEmailwith(email:String){
		Provider.backgroundService.request(.checkEmail(email: email)) { (result) in
			switch result {
			case let .success(response):
				let data = response.data
				let json = JSON(data)
				print(json)
				let emailExist = json["existed_email"].bool
				self.delegate?.emailSuccess(emailExist: emailExist)
			case let .failure(error):
				self.delegate?.emailFailure(msg:error.localizedDescription)
			}
		}
	}
}
