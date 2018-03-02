//
//  LandForSaleViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/1/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import  RxCocoa
import  RxSwift

class LandForSaleViewController: BaseViewController {

    @IBOutlet weak var btnBackMaps: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var inforTile: UILabel!
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var heightConstraintHeader: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    var isShowHeader:Bool = true
    var page:Int = 0
    var isLoad: Bool = true
    var isLoading: Bool = false
    var listData:[LandSaleModel] = []
    let disposeBag = DisposeBag()
    
    var idProject:String = "null"
    var idDistrict:String = "null"
    var idCity = "null"
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
    var isNewsApproved:Int = 2
    var isGoverment:Int = 2
    var isWaitForSale:Int = 2
    var isAvailability:Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.setting()
        self.showHUD("")
        self.loadData(refresh: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    // MARK: - LoadData
    
    func loadData(refresh: Bool)
    {
        
        if self.isLoading == false {
            self.isLoading = true
            APIClient.shared.searchLandSale(project_id: self.idProject, title: self.titleSearch, type: self.type, city: self.idCity, ward: self.idWards, area_min: self.are_min, area_max: self.are_max, price_min: self.pricae_min, price_max: self.price_max, district: self.idDistrict, numberbedroom: self.idBedRoom, direction: self.idDirection, page: self.page,isNewsApproved: self.isNewsApproved,isGoverment: self.isGoverment,isWaitForSale: self.isWaitForSale,isAvailability: self.isAvailability).asObservable().bind(onNext: { result in
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
                    self.listData.append(contentsOf: projects)
                    if self.listData.count != 0 && refresh == true {
                        var array: [NSIndexPath]! = []
                        let index: Int = self.listData.count - projects.count
                        for i in index..<self.listData.count {
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
    
    func refresh(_ sender: Any) {
        self.listData = []
        self.isLoad = true
        self.page = 0
        self.idProject = "null"
        self.idDistrict = "null"
        self.idCity = "null"
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
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl?.addTarget(self, action: #selector(LandForSaleViewController.refresh(_:)), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refreshControl!)
    }

    
    // MARK: - back to mapsviewcontroller
    @IBAction func backToMapsButtonDidTap(_ sender: Any) {
        SaveCurrentVC.shared.homeController.tutorialPageViewController?.scrollToViewController(index: 2)
    }
    
    @IBAction func searchButtonDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
        let searchController = storyboard.instantiateViewController(withIdentifier: "SearchLandForSaleViewController") as? SearchLandForSaleViewController
        searchController?.delegate = self
        self.pushViewController(viewController: searchController!)
    }

}

extension LandForSaleViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < self.listData.count {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "LandForSaleViewCell") as! LandForSaleViewCell
            cell.loadDataCell(cell: self.listData[indexPath.row], index: indexPath.row, type: 3)
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < self.listData.count {
            let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
            let showDetail = storyboard.instantiateViewController(withIdentifier: "DetailLanforSaleViewController") as? DetailLanforSaleViewController
            showDetail?.isSale = true
            showDetail?.landForSale = self.listData[indexPath.row]
            
            self.pushViewController(viewController: showDetail)
        }
       
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        let end = scrollView.contentSize.height
        if self.listData.count >= 10 {
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

extension LandForSaleViewController:SearchLandForSaleViewControllerDelegate{
    func searchLand(_ controlelr: SearchLandForSaleViewController, _ project_id: String, _ title: String, _ type: String, _ city: String, _ ward: String, _ area_min: String, _ area_max: String, _ price_min: String, _ price_max: String, _ district: String, _ numberbedroom: String, _ direction: String, _ isNewsApproved: Int, _ isGoverment: Int, _ isWaitForSale: Int, _ isAvailability: Int) {
        self.idProject = project_id
        self.titleSearch = title
        self.type = type
        self.idCity = city
        self.idWards = ward
        self.are_min = area_min
        self.are_max = area_max
        self.pricae_min = price_min
        self.price_max = price_max
        self.idDistrict = district
        self.idBedRoom = numberbedroom
        self.idDirection = direction
        self.isNewsApproved = isNewsApproved
        self.isWaitForSale = isWaitForSale
        self.isAvailability = isAvailability
        self.isGoverment = isGoverment
        self.showHUD("")
        self.listData = []
        self.page = 0
        self.tableView.reloadData()
        self.loadData(refresh: true)
    }

}
extension LandForSaleViewController:LandForSaleViewCellDelegate
{
    func deleteSaveNews(_ cell: LandForSaleViewCell, news: NewsModel, index: Int,type:Int) {
       
    }
    func deleteSaveLand(_ cell: LandForSaleViewCell, land: LandSaleModel, index: Int, type: Int) {
        self.showHUD("")
        if land.isLike == true
        {
            APIClient.shared.cancelNews(id: land.id, type: type).asObservable().bind(onNext: { result in
                self.hideHUD()
                self.updateRowLand(item:land, index: index, type: type,status: false)
            }).disposed(by: self.disposeBag)
        }
        else
        {
            APIClient.shared.saveNews(id: land.id, type: type).asObservable().bind(onNext: { result in
                self.hideHUD()
                self.updateRowLand(item: land, index: index,type: type,status: true)
            }).disposed(by: self.disposeBag)
        }
    }
    
    func deleteSaveProject(_ cell: LandForSaleViewCell, project: ProjectsModel, index: Int, type: Int) {
     
        
    }
    
    func updateRowLand(item: LandSaleModel!,index:Int,type:Int,status:Bool)
    {
        if index >= 0 {
            if status == true
            {
                Util.shared.listBDS.append(item)
            }
            else
            {
                if Util.shared.listBDS.count > 0
                {
                    for i in 0..<(Util.shared.listBDS.count - 1 )
                    {
                        if Util.shared.listBDS[i].id == item.id
                        {
                            Util.shared.listBDS.remove(at: i)
                        }
                        
                    }
                }
            }
            self.listData[index].isLike = status
            let indexPath = NSIndexPath(row: index, section: 0)
            var arrayIndext: [NSIndexPath] = []
            arrayIndext.append(indexPath)
            self.tableView.beginUpdates()
            self.tableView.reloadRows(at: arrayIndext as [IndexPath], with: UITableViewRowAnimation.fade)
            self.tableView.endUpdates()
        }
        
    }
}

