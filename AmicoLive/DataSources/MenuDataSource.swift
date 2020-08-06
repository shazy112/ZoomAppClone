//
//  MenuDataSource.swift
//  AmicoLive
//
//  Created by Invision on 20/12/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import Foundation
import UIKit
class MenuDataSource : NSObject , UITableViewDataSource {
	
	var menuData : [MenuOption] = []
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return menuData.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? MenuOptionTableViewCell else {return UITableViewCell()}
		if indexPath.row == menuData.count - 1{
			cell.borderView.isHidden = true
		}
		cell.option = menuData[indexPath.row]
		return cell
	}
}
