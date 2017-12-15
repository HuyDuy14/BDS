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
    
    var idProjects:String = "null"
    var idDistricts:String = "null"
    var idCitys = "null"
    var idWards:String = "null"
    var idDirection = "null"
    var idAcreage = "null"
    var idBedRoom = "null"
    var titleSearch = "null"
    var idBedroom = "null"
    var price_max = "null"
    var pricae_min = "null"
    var are_min = "null"
    var are_max = "null"
    var type = "null"
    
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
            self.inforHeader.text = "Tìm kiếm dự án theo lựa chọn"
            self.listProject = []
            self.btnBackHome.setImage(#imageLiteral(resourceName: "icon_back"), for: .normal)
            self.btnBackMaps.isHidden = true
            self.loadDataproject(refresh: true)
        }
        else
        {
            self.titleHeader.text = "Nhà đất thuê"
            self.inforHeader.text = "Tìm kiếm nhà đất thuê"
            self.page = 0
            self.btnBackHome.setImage(#imageLiteral(resourceName: "icon_back_maps"), for: .normal)
            self.btnBackMaps.isHidden = false
            self.listProject = []
            self.loadData(refresh: true)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    func refresh(_ sender: Any) {
        if  isBackHome == false
        {
            self.page = 0
            self.listProject = []
            self.loadDataproject(refresh: false)
        }
        else
        {
            self.page = 0
            self.listProject = []
            self.idProjects = "null"
            self.idDistricts = "null"
            self.idCitys = "null"
            self.idWards = "null"
            self.idDirection = "null"
            self.idBedRoom = "null"
            self.titleSearch = "null"
            self.idBedroom = "null"
            self.price_max = "null"
            self.pricae_min = "null"
            self.are_min = "null"
            self.are_max = "null"
            self.type = "null"
            self.loadData(refresh: false)
        }
  
    }
    
    // MARK: - Get data
    
    func loadDataproject(refresh: Bool)
    {
        if self.isLoading == false {
            self.isLoading = true
            APIClient.shared.searchProjects(idProject: self.idProject, idCity: self.idCity, idDistrict: self.idDictrict,page:self.page).asObservable().bind(onNext: {result in
                
                DispatchQueue.main.async {
                    var projects: [ProjectsModel] = []
                    for data in result.dataArray
                    {
                        if let dic = data as? [String:Any]
                        {
                            let project = ProjectsModel(JSON: dic)
                            for p in Util.shared.listProjectSave
                            {
                                if p.id == project?.id{
                                    project?.isLike = true
                                }
                            }
                            projects.append(project!)
                        }
                    }

                    if projects.count == 0
                    {
                        self.isLoad = false
                    }
                    self.listProject.append(contentsOf: projects)
                    
                    if self.listProject.count != 0 && refresh == true {
                        var array: [IndexPath]! = []
                        let index: Int = self.listProject.count - projects.count
                        for i in index..<self.listProject.count {
                            array.append( IndexPath(row: i, section: 0))
                        }
                        self.tableView.beginUpdates()
                        self.tableView.insertRows(at: array, with: .automatic)
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
    

    func loadData(refresh: Bool)
    {
        
        if self.isLoading == false {
            self.isLoading = true
            APIClient.shared.searchLandRent(project_id: self.idProjects, title: self.titleSearch, type: self.type, city: self.idCitys, ward: self.idWards, area_min: self.are_min, area_max: self.are_max, price_min: self.pricae_min, price_max: self.price_max, district: self.idDistricts, numberbedroom: self.idBedRoom, direction: self.idDirection, page: self.page).asObservable().bind(onNext: { result in
                DispatchQueue.main.async {
                    var projects: [LandSaleModel] = []
                    for data in result.dataArray
                    {
                        if let dic = data as? [String:Any]
                        {
                            let project = LandSaleModel(JSON: dic)
                            for land in Util.shared.listBDS
                            {
                                if land.id == project?.id{
                                    project?.isLike = true
                                }
                            }
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
            let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
            let searchController = storyboard.instantiateViewController(withIdentifier: "SearchLandForSaleViewController") as? SearchLandForSaleViewController
            searchController?.delegate = self
            searchController?.isRale = false
            self.pushViewController(viewController: searchController!)
        }
        else
        {
           SaveCurrentVC.shared.homeController.tutorialPageViewController?.scrollToViewController(index: 2)
            self.popToRootViewController(controller: SaveCurrentVC.shared.homeController)
        }
    }
    
    @IBAction func backToHomeButtonDidTap(_ sender: Any) {
        if isBackHome == true {
            SaveCurrentVC.shared.homeController.tutorialPageViewController?.scrollToViewController(index: 2)
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
                cell.loadDataHome(project: self.listLandSent[indexPath.row],index: indexPath.row,type: 3)
                cell.delegate = self
                return cell
            }
        }
        else
        {
            if self.listProject.count > indexPath.row
            {
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "ProjectViewCell") as! ProjectViewCell
                cell.loadData(project: self.listProject[indexPath.row], index: indexPath.row,type: 2)
                cell.delegate = self
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if  isBackHome == false
        {
            let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
            let end = scrollView.contentSize.height
            if self.listProject.count >= 10  {
                if (bottomEdge >= end)
                {
                    self.page += 1
                    if self.isLoad == true
                    {
                        self.showHUD("")
                        self.loadDataproject(refresh: true)
                    }
                }
            }
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

extension ProjectsViewController:SearchLandForSaleViewControllerDelegate{
    
    func searchLand(_ controlelr: SearchLandForSaleViewController, _ project_id: String, _ title: String, _ type: String, _ city: String, _ ward: String, _ area_min: String, _ area_max: String, _ price_min: String, _ price_max: String, _ district: String, _ numberbedroom: String, _ direction: String) {
        self.idProjects = project_id
        self.titleSearch = title
        self.type = type
        self.idCitys = city
        self.idWards = ward
        self.are_min = area_min
        self.are_max = area_max
        self.pricae_min = price_min
        self.price_max = price_max
        self.idDistricts = district
        self.idBedRoom = numberbedroom
        self.idDirection = direction
        self.showHUD("")
        self.listLandSent = []
        self.page = 0
        self.tableView.reloadData()
        self.loadData(refresh: true)
    }
}

extension ProjectsViewController:ProjectViewCellDelegate{
    
    func updateRow(item: ProjectsModel!, status: Bool,index:Int)
    {
        if index >= 0 {
            if status == true
            {
                Util.shared.listProjectSave.append(item)
            }
            else
            {
                for i in 0..<(Util.shared.listProjectSave.count-1)
                {
                    if Util.shared.listProjectSave[i].id == item.id
                    {
                        Util.shared.listProjectSave.remove(at: i)
                    }
                  
                }
            }
            self.listProject[index].isLike = status
            let indexPath = NSIndexPath(row: index, section: 0)
            var arrayIndext: [NSIndexPath] = []
            arrayIndext.append(indexPath)
            self.tableView.beginUpdates()
            self.tableView.reloadRows(at: arrayIndext as [IndexPath], with: UITableViewRowAnimation.fade)
            self.tableView.endUpdates()
        }
        
    }
    
    func updateRowLand(item: LandSaleModel!, status: Bool,index:Int)
    {
        if index >= 0 {
            if status == true
            {
                Util.shared.listBDS.append(item)
            }
            else
            {
                for i in 0..<(Util.shared.listBDS.count - 1)
                {
                    if Util.shared.listBDS[i].id == item.id
                    {
                        Util.shared.listBDS.remove(at: i)
                    }
                    
                }
            }
            self.listLandSent[index].isLike = status
            let indexPath = NSIndexPath(row: index, section: 0)
            var arrayIndext: [NSIndexPath] = []
            arrayIndext.append(indexPath)
            self.tableView.beginUpdates()
            self.tableView.reloadRows(at: arrayIndext as [IndexPath], with: UITableViewRowAnimation.fade)
            self.tableView.endUpdates()
        }
        
    }

    func saveLand(_ cell: ProjectViewCell, project: LandSaleModel, index: Int, type: Int) {
        self.showHUD("")
        if project.isLike == false
        {
            APIClient.shared.saveNews(id: project.id, type: type).asObservable().bind(onNext: { result in
                self.hideHUD()
                self.updateRowLand(item: project, status: true, index: index)
            }).disposed(by: self.disposeBag)
        }
        else
        {
            APIClient.shared.cancelNews(id: project.id, type: type).asObservable().bind(onNext: { result in
                self.hideHUD()
                self.updateRowLand(item: project, status: false, index: index)
            }).disposed(by: self.disposeBag)
        }
    }
    
    func saveProject(_ cell: ProjectViewCell, project: ProjectsModel, index: Int, type: Int) {
        self.showHUD("")
        if project.isLike == false
        {
            APIClient.shared.saveNews(id: project.id, type: type).asObservable().bind(onNext: { result in
                self.hideHUD()
                self.updateRow(item: project, status: true, index: index)
            }).disposed(by: self.disposeBag)
        }
        else
        {
            APIClient.shared.cancelNews(id: project.id, type: type).asObservable().bind(onNext: { result in
                self.hideHUD()
                self.updateRow(item: project, status: false, index: index)
            }).disposed(by: self.disposeBag)
        }
    }
}
