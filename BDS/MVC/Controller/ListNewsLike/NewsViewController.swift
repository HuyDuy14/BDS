//
//  NewsViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/1/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class NewsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }

    @IBAction func backButtonDidTap(_ sender: Any) {
        self.popToView()
    }
    
    @IBAction func selectCategoryButtonDidTap(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
        let vcCategory = storyboard.instantiateViewController(withIdentifier: "PopupCategoryNewsViewController") as? PopupCategoryNewsViewController
        vcCategory?.finish = { index in
            print(index)
        }
        vcCategory?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        vcCategory?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(vcCategory!, animated: true, completion: nil)
    }
}
extension NewsViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "NewsViewCell") as! NewsViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
        let vcDetail = storyboard.instantiateViewController(withIdentifier: "DetailNewsViewController") as? DetailNewsViewController
        self.pushViewController(viewController: vcDetail)
    }
}
