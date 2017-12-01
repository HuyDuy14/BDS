//
//  NewsLikeViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/1/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class NewsLikeViewController: BaseViewController {

    @IBOutlet weak var tbaleView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbaleView.delegate = self
        self.tbaleView.dataSource = self
    }

    @IBAction func backButtonDidTap(_ sender: Any) {
        SaveCurrentVC.shared.homeController.tutorialPageViewController?.scrollToViewController(index: 0)
    }
    

}
extension NewsLikeViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tbaleView.dequeueReusableCell(withIdentifier: "NewsLikeViewCell") as! LandForSaleViewCell
        
        return cell
    }
}
