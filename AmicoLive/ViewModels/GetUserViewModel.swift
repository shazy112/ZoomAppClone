import SwiftyJSON
import Moya

protocol GetUserDelegate:class {
	func success(users:Users)
	func failure(message:String?)
}

class GetUserViewModel {
	weak var delegate:GetUserDelegate?
	static var currentPage = 1
	
	init(delegate:GetUserDelegate) {
		self.delegate = delegate
	}
	
	func getUsers(){
		Provider.services.request(.getUser(UserId: Defaults.emailId ?? "")) { (result) in
			switch result {
			case let .success(response):
				let data = response.data
				let json = JSON(data)
				print(json)
				let user = Users.init(json: json)
				self.delegate?.success(users: user)
			case let .failure(error):
				
				self.delegate?.failure(message:error.localizedDescription)
			}
		}
	}
}
