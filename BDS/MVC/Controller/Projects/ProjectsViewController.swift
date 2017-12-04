//
//  ProjectsViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/1/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ProjectsViewController: BaseViewController {

    @IBOutlet weak var btnBackMaps: UIButton!
    @IBOutlet weak var btnBackHome: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    var idProject:Int = 0
    var idCity:Int = 0
    var idDictrict:Int = 0
    var listProject:[ProjectsModel] = []
    
    var isBackHome:Bool = true
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
 
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl?.addTarget(self, action: #selector(ProjectsViewController.refresh(_:)), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refreshControl!)
        self.showHUD("")
        self.loadDataproject()
    }
    
    func refresh(_ sender: Any) {
        self.listProject = []
        self.loadDataproject()
    }
    
    // MARK: - Get data
    
    func loadDataproject()
    {
        self.listProject = []
        APIClient.shared.searchProjects(idProject: self.idProject, idCity: self.idCity, idDistrict: self.idDictrict).asObservable().bind(onNext: {result in

            for data in result.dataArray
            {
                if let dic = data as? [String:Any]
                {
                    let project = ProjectsModel(JSON: dic)
                    self.listProject.append(project!)
                }
            }
            
            DispatchQueue.main.async {
                 self.tableView.reloadData()
            }
            
            self.refreshControl.endRefreshing()
            self.hideHUD()
           
            
        }).disposed(by: self.disposeBag)
        
    }
    
    func loadData()
    {
        self.showHUD("")
        APIClient.shared.getLandForSale(type: "sale").asObservable().bind(onNext: {result in
            
            self.hideHUD()
            
        }).disposed(by: self.disposeBag)
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
        return self.listProject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if self.listProject.count > indexPath.row
       {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "ProjectViewCell") as! ProjectViewCell
            cell.loadData(project: self.listProject[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

