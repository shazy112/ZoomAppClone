//
//  Constants.swift
//  AmicoLive
//
//  Created by Invision on 28/11/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import UIKit

struct Constants{
	static let baseUrl = "https://api.zoom.us/v2/"
	static let invitationLink = "I am using Amico Live for video meeting and chat. Get the free app at Appstore http://itunes.apple.com/app/id1444757217"
	struct Zoom{
		static let SDKKey = "2dZKwFXQD2PFGCl9j5U1rqIawLEdqzbIjUur"
		static let SDKSecret = "UoXS7B42ueTVr2bUWfPJIMlcV3xm8vKbjlV5"
		static let APIKey = "wzJQSuMITkiwLi1ZY1cLOg"
		static let APISecret = "R2A5mGT9h4Xhgx7mdXPM8DQoSkfxgwdh669d"
	}
	
	struct vcIdentifiers {
		static let mainNavController = "DetailNavController"
		static let signinViewController = "SignInNavController"
		static let customSplashViewController = "CustomSplashViewController"
		static let menuViewController =  "MenuViewController"
		static let homeViewController = "HomeViewController"
	}
	struct DefaultKeys {
		static let login = "login"
		static let emailId = "emailId"
		static let pmi = "pmi"
	}
	
}
