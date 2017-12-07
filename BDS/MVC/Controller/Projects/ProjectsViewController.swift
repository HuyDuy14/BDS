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
    @IBOutlet weak var titleHeader: UILabel!
    @IBOutlet weak var inforHeader: UILabel!
    
    var refreshControl: UIRefreshControl!
    var idProject:Int = 0
    var idCity:Int = 0
    var idDictrict:Int = 0
    var listProject:[ProjectsModel] = []
    var listLandSent:[LandSaleModel] = []
    
    var page:Int = 0
    var isLoad: Bool = true
    var isLoading: Bool = false
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
        if  isBackHome == false
        {
            self.titleHeader.text = "Danh sách dự án"
            self.inforHeader.text = "Tìm kiếm dự án theo yêu lựa chọn"
            self.listProject = []
            self.btnBackMaps.isHidden = true
            self.loadDataproject()
        }
        else
        {
            self.titleHeader.text = "Nhà đất thuê"
            self.inforHeader.text = "Tìm kiếm nhà đất thuê"
            self.page = 0
            self.btnBackMaps.isHidden = false
            self.listProject = []
            self.loadData(refresh: false)
        }
        
    }
    
    func refresh(_ sender: Any) {
        if  isBackHome == false
        {
            self.listProject = []
            self.loadDataproject()
        }
        else
        {
            self.page = 0
            self.listProject = []
            self.loadData(refresh: false)
        }
  
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
    

    func loadData(refresh: Bool)
    {
        
        if self.isLoading == false {
            self.isLoading = true
            APIClient.shared.searchLandRent(project_id: "null", title: "null", type: "null", city: "null", ward: "null", area_min: "null", area_max: "null", price_min: "null", price_max: "null", district: "null", numberbedroom: "null", direction: "null", page: self.page).asObservable().bind(onNext: { result in
                DispatchQueue.main.async {
                    var projects: [LandSaleModel] = []
                    for data in result.dataArray
                    {
                        if let dic = data as? [String:Any]
                        {
                            let project = LandSaleModel(JSON: dic)
                           projects.append(project!)
                        }
                    }
                    
                    if projects.count == 0
                    {
                        self.isLoad = false
                    }
                    self.listLandSent.append(contentsOf: projects)
                
                    if self.listLandSent.count != 0 && refresh == true {
                        var array: [NSIndexPath]! = []
                        let index: Int = self.listLandSent.count - projects.count
                        for i in index..<self.listLandSent.count {
                            array.append( NSIndexPath(row: i, section: 0))
                        }
                        self.tableView.beginUpdates()
                        self.tableView.insertRows(at: array! as [IndexPath], with: .automatic)
                        self.tableView.endUpdates()
                    } else {
                        self.tableView.reloadData()
                    }
                    self.isLoading = false
                    self.refreshControl?.endRefreshing()
                    self.hideHUD()
                }
            }).disposed(by: self.disposeBag)
        }
        
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
        if self.isBackHome == true
        {
            return self.listLandSent.count
        }
        return self.listProject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.isBackHome == true
        {
            if self.listLandSent.count > indexPath.row
            {
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "ProjectViewCell") as! ProjectViewCell
                cell.loadDataHome(project: self.listLandSent[indexPath.row])
                return cell
            }
        }
        else
        {
            if self.listProject.count > indexPath.row
            {
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "ProjectViewCell") as! ProjectViewCell
                cell.loadData(project: self.listProject[indexPath.row])
                return cell
            }
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
            if  isBackHome == false
            {
                if self.listProject.count > indexPath.row
                {
                    let storyboard = UIStoryboard(name: "Projects", bundle: nil)
                    let showDetail = storyboard.instantiateViewController(withIdentifier: "DetailProjectViewController") as? DetailProjectViewController
                    showDetail?.project = self.listProject[indexPath.row]
                    self.pushViewController(viewController: showDetail)
                }
            }
            else
            {
                if self.listLandSent.count > indexPath.row
                {
                    let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
                    let showDetail = storyboard.instantiateViewController(withIdentifier: "DetailLanforSaleViewController") as? DetailLanforSaleViewController
                    showDetail?.landForSale = self.listLandSent[indexPath.row]
                    self.pushViewController(viewController: showDetail)
                }
            }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if  isBackHome == false
        {
            return
        }
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        let end = scrollView.contentSize.height
        if self.listLandSent.count >= 10  {
            if (bottomEdge >= end)
            {
                self.page += 1
                if self.isLoad == true
                {
                    self.showHUD("")
                    self.loadData(refresh: true)
                }
            }
        }
    }
}

