//
//  LandForSaleViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/1/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class LandForSaleViewController: BaseViewController {

    @IBOutlet weak var btnBackMaps: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var inforTile: UILabel!
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var heightConstraintHeader: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var isShowHeader:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.setting()
        
    }
    
    // MARK: - setting controller
    
    func setting(){
        if self.isShowHeader == false {
            self.heightConstraintHeader.constant = 0
            self.btnSearch.isHidden = true
            self.btnBackMaps.isHidden = true
            self.inforTile.isHidden = true
            self.nameTitle.isHidden = true
        }
        else
        {
            self.heightConstraintHeader.constant = 70
            self.btnSearch.isHidden = false
            self.btnBackMaps.isHidden = false
            self.inforTile.isHidden = false
            self.nameTitle.isHidden = false
        }
    }

    // MARK: - back to mapsviewcontroller
    @IBAction func backToMapsButtonDidTap(_ sender: Any) {
        SaveCurrentVC.shared.homeController.tutorialPageViewController?.scrollToViewController(index: 2)
    }
    
    @IBAction func searchButtonDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
        let searchController = storyboard.instantiateViewController(withIdentifier: "SearchLandForSaleViewController") as? SearchLandForSaleViewController
        self.pushViewController(viewController: searchController!)
    }

}

extension LandForSaleViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "LandForSaleViewCell") as! LandForSaleViewCell
        
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
