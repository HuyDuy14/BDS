//
//  ContactsViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/1/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class ContactsViewController: BaseViewController {

    @IBOutlet weak var headerView: HeaderViewController!
    @IBOutlet weak var tbaleView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbaleView.delegate = self
        self.tbaleView.dataSource = self
        self.headerView.delegate = self
        self.headerView.setTitleView(title: "Danh bạ nhà môi giới", infor: "Danh sách tìm kiếm môi giới chuyên nghiệp")
    }
}
extension ContactsViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tbaleView.dequeueReusableCell(withIdentifier: "ContactViewCell") as! ContactViewCell
        return cell
    }
}

