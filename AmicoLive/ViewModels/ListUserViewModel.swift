
import Foundation
import SwiftyJSON
import Moya

protocol ListUserDelegaete:class {
	func success(users:ListUsers)
	func failure(message:String?)
}

class ListUserViewModel {
	weak var delegate:ListUserDelegaete?
	 var currentPage = 0
	var pageCount:Int?
	init(delegate:ListUserDelegaete) {
		self.delegate = delegate
	}
	
	func listUserer(){
		if pageCount == nil || currentPage < pageCount!{
			self.currentPage+=1
		Provider.services.request(.listUsers(status: "active", pageSize: 30, pageNumber: currentPage)) { (result) in
			switch result {
				
			case let .success(response):
				
				let data = response.data
				let json = JSON(data)
				print(json)
				self.pageCount = json["page_count"].int
				let users = ListUsers.init(object: json.dictionaryValue)
				self.delegate?.success(users: users)
			case let .failure(error):
				self.delegate?.failure(message:error.localizedDescription)
			}
			}
			
		}
	}
}
