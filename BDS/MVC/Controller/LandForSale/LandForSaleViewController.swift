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

protocol LandForSaleViewControllerDelegate:class
{
    func disLoadDataMaps(_ controller:LandForSaleViewController,listData:[LandSaleModel])
}

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
    weak var delegate:LandForSaleViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.setting()
        self.showHUD("")
        self.loadData(refresh: true)
        
    }
    
    // MARK: - LoadData
    
    func loadData(refresh: Bool)
    {
        
        if self.isLoading == false {
            self.isLoading = true
            APIClient.shared.getListLandSale(page: self.page).asObservable().bind(onNext: {result in
                DispatchQueue.main.async {
                    var listLandSaleModel: [LandSaleModel] = []
                    for data in result.dataArray
                    {
                        if let dic = data as? [String:Any]
                        {
                            let landSaleModel = LandSaleModel(JSON: dic)
                            listLandSaleModel.append(landSaleModel!)
                        }
                    }
                    
                    if listLandSaleModel.count == 0
                    {
                        self.isLoad = false
                    }
                    self.listData.append(contentsOf: listLandSaleModel)
                    self.delegate?.disLoadDataMaps(self, listData:  self.listData)
                    if self.listData.count != 0 && refresh == true {
                        var array: [NSIndexPath]! = []
                        let index: Int = self.listData.count - listLandSaleModel.count
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
            cell.loadDataCell(cell: self.listData[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        let end = scrollView.contentSize.height
        if self.listData.count >= 5  {
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
