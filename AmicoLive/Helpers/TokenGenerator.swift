//
//  TokenGenerator.swift
//  AmicoLive
//
//  Created by Invision on 28/11/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import Foundation
import JWT

class TokenGenerator{
	
	static var tokenExpiry:TimeInterval{
		return Calendar.current.date(byAdding: .year,
									 value: 1, to: Date())!.timeIntervalSince1970
	}
	
	class func generate()->String{
		let token = JWT.encode(claims: ["iss": Constants.Zoom.APIKey,
										"exp": tokenExpiry],
							   algorithm: .hs256(Constants.Zoom.APISecret.data(using: .utf8)!))
		
		return "Bearer \(token)"
	}
}
