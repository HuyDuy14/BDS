//
//  ProjectsViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/1/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class ProjectsViewController: BaseViewController {

    @IBOutlet weak var btnBackMaps: UIButton!
    @IBOutlet weak var btnBackHome: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var isBackHome:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
       
        
    }

    // MARK: - back to mapsviewcontroller
    @IBAction func backToMapsButtonDidTap(_ sender: Any) {
        if isBackHome == true {
            SaveCurrentVC.shared.homeController.tutorialPageViewController?.scrollToViewController(index: 2)
        }
        else
        {
           SaveCurrentVC.shared.homeController.tutorialPageViewController?.scrollToViewController(index: 2)
            self.popToRootViewController(controller: SaveCurrentVC.shared.homeController)
        }
    }
    
    @IBAction func backToHomeButtonDidTap(_ sender: Any) {
        if isBackHome == true {
            SaveCurrentVC.shared.homeController.tutorialPageViewController?.scrollToViewController(index: 0)
        }
        else
        {
            self.popToView()
        }
    }
    
}

extension ProjectsViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ProjectViewCell") as! ProjectViewCell
        
        if indexPath.row % 2 == 0 {
            cell.imageLike.tintColor = UIColor.lightGray
        }
        else
        {
            cell.imageLike.tintColor = UIColor.red
        }
        
        return cell
    }
}

