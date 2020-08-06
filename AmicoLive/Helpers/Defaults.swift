//
//  Defaults.swift
//  AmicoLive
//
//  Created by Invision on 10/12/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import Foundation
import UIKit

class Defaults {
 static let defaults = UserDefaults.standard
	class var isloggedIn:Bool?{
		set{
			defaults.setValue(newValue, forKey: Constants.DefaultKeys.login)
		}
		get{
			return defaults.value(forKey: Constants.DefaultKeys.login) as? Bool
		}
	}
	
	class var emailId:String?{
		set{
			defaults.setValue(newValue, forKey: Constants.DefaultKeys.emailId)
		}
		get{
			return defaults.value(forKey: Constants.DefaultKeys.emailId) as? String
		}
	}
	class var pmi:String?{
		set{
			defaults.setValue(newValue, forKey: Constants.DefaultKeys.pmi)
		}
		get{
			return defaults.value(forKey: Constants.DefaultKeys.pmi) as? String
		}
	}
	
	
}

