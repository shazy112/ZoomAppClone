//
//  AddContactOptionsViewController.swift
//  AmicoLive
//
//  Created by Invision on 17/12/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import UIKit

class AddContactOptionsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}
extension AddContactOptionsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       return tableView.dequeueReusableCell(withIdentifier:"Cell") as! AddContactsTableViewCell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
}
