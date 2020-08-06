//
//  User.swift
//  AmicoLive
//
//  Created by Invision on 20/12/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import Foundation
class User{
	static var shared :User = User()
	var users:Users?
	private init(){}
}
