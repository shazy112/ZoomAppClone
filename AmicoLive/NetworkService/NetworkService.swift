//
//  AuthenticationService
//  OpenHouseStar
//
//  Created by mac on 8/28/18.
//  Copyright © 2018 Invision-MacBookPro-Farooq. All rights reserved.
//



import Moya
import Alamofire
import Foundation
import JGProgressHUD

struct Provider {
	static let services = MoyaProvider<Services>(plugins:[Plugin.networkPlugin])
	static let backgroundService = MoyaProvider<Services>()
}
struct Plugin{

	static let networkPlugin = NetworkActivityPlugin.init(networkActivityClosure: { (changeType, targetType) in
		switch (changeType){
		case .began:
			print("began")
			UIApplication.startActivityIndicator()
		case .ended:
			UIApplication.stopActivityIndicator()
			print("ended")
		}
	})
}

enum Services{

	case listUsers(status:String,pageSize:Int,pageNumber:Int)
	case getUser(UserId:String)
	case checkEmail(email:String)
}

extension Services : TargetType {

	var baseURL : URL {
		return URL(string: Constants.baseUrl)!
	}


	var path: String {

		switch self {
		case .listUsers:
			return "users"
		case .getUser(let userid):
			return "users/\(userid)"
		case .checkEmail:
			return "users/email"
		}

	}
	var method: Moya.Method {
		switch self {
		case .listUsers,.getUser,.checkEmail:
			return .get
}
	}

	var task: Task {

		switch self {
		case .listUsers(let status, let pageSize,let pageNumber):
			let params = ["status":status,
						  "page_size":pageSize,
						  "page_number":pageNumber] as [String : Any]
		  return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
			
		case .getUser(let userId):
//			let params = ["userId":userId] as [String : Any]
			return .requestPlain
			
		case .checkEmail(let email):
			let param = ["email":email]
			return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
		}

	}

	var sampleData: Data {
		return Data()
	}


	var validationType: ValidationType{
		return .successCodes
	}

	var headers: [String: String]? {
		switch self {
		case .listUsers,.getUser,.checkEmail:
			return ["Content-type": "application/json","Authorization":TokenGenerator.generate()]
			//return ["Content-type": "application/json"]
//		case.getQuestions:
//			return ["Accept": "application/json","Authorization":Constants.token]
//		case.postAnsweres:
//			return ["Accept": "application/json","Authorization":Constants.token]
//		case .postAnsweresToServer,.getCareers,.getCourses,.searchCourseForCareer,.getUser,.changeCareer,.addToDoCourse,.getToDoCourses,.getAnsweres(),.globalSearch,.updateCourseStatus:
//			return ["Content-type": "application/json","Authorization":Defaults.token! ]
//
//		case .editProfile:
//			return ["Content-type": "multipart/form-data","Authorization":Defaults.token! ]

		}
	}

}
// MARK: - Helpers
private extension String {
	var urlEscaped: String {
		return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
	}

	var utf8Encoded: Data {
		return data(using: .utf8)!
	}
}



