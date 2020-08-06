//
//  ForgotPasswordViewController.swift
//  AmicoLive
//
//  Created by Invision on 15/05/2019.
//  Copyright © 2019 Invision. All rights reserved.
//

import UIKit
import WebKit
class ForgotPasswordViewController: UIViewController {

	@IBOutlet weak var webView: WKWebView!
	override func viewDidLoad() {
        super.viewDidLoad()
		let url = URL(string: "https://zoom.us/forgot_password")
		webView.load(URLRequest(url: url!))
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
