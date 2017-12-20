//
//  NewsLikeViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/1/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import RxSwift

class NewsLikeViewController: BaseViewController {

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var desView: UILabel!
    
    @IBOutlet weak var tbaleView: UITableView!
    var refreshControl: UIRefreshControl!
    let disposeBag = DisposeBag()
    var listData:NewsSaveModel = NewsSaveModel()
    var isMenu:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbaleView.delegate = self
        self.tbaleView.dataSource = self
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl?.addTarget(self, action: #selector(NewsLikeViewController.refresh(_:)), for: UIControlEvents.valueChanged)
        self.tbaleView.addSubview(refreshControl!)
       self.tbaleView.register(UINib.init(nibName: "NewsHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier:  "NewsHeaderView")
        self.getDataNews()
        if isMenu == true {
            self.titleView.text = "Tin đã đăng"
            self.desView.text = "Thông tin những tin bạn đã đăng"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tbaleView.reloadData()
        self.getDataNews()
    }
    
    func refresh(_ sender: Any) {
        self.getDataNews()
    }
    
    func getDataNews()
    {
       
        APIClient.shared.getNewsSave(isMenu:self.isMenu).asObservable().bind(onNext: { result in
            self.listData.listBDS = []
            for data in result.dataArray
            {
                if let dic = data as? [String:Any]
                {
                    let bds =  LandSaleModel(JSON:dic)
                    self.listData.listBDS.append(bds!)
                }
               
            }
            Util.shared.listBDS = self.listData.listBDS
           
            for bds in Util.shared.listBDS
            {
                bds.isLike = true
            }
            self.tbaleView.reloadData()
            self.refreshControl.endRefreshing()
            self.hideHUD()
        }).disposed(by: self.disposeBag)
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
       
        if isMenu == false
        {
            SaveCurrentVC.shared.homeController.tutorialPageViewController?.scrollToViewController(index: 0)
        }
        else
        {
            self.popToView()
        }
    }
    

}
extension NewsLikeViewController:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Util.shared.listBDS.count
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch indexPath.section
//        {
//        case 0:
//            let cell = self.tbaleView.dequeueReusableCell(withIdentifier: "NewsLikeViewCell") as! LandForSaleViewCell
//            cell.loadDataNewsCell(cell: self.listData.listNews[indexPath.row], index: indexPath.row, type: 1)
//            cell.delegate = self
//            cell.imageLike.tintColor = UIColor.red
//            return cell
//        case 1:
//            let cell = self.tbaleView.dequeueReusableCell(withIdentifier: "NewsLikeViewCell") as! LandForSaleViewCell
//            cell.loadDataProject(project: self.listData.listProjects[indexPath.row], index: indexPath.row, type: 2)
//            cell.delegate = self
//            cell.imageLike.tintColor = UIColor.red
//            return cell
//        case 2:
        if self.listData.listBDS.count > indexPath.row
        {
            let cell = self.tbaleView.dequeueReusableCell(withIdentifier: "NewsLikeViewCell") as! LandForSaleViewCell
            cell.loadDataCell(cell: Util.shared.listBDS[indexPath.row], index: indexPath.row, type: 3)
            cell.delegate = self
            cell.imageLike.tintColor = UIColor.red
            return cell
        }
        return UITableViewCell()
//        default:
//            return UITableViewCell()
//        }
        
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let headerView = self.tbaleView.dequeueReusableHeaderFooterView(withIdentifier: "NewsHeaderView") as? NewsHeaderView
//        switch section
//        {
//        case 0:
//             headerView?.nameHeader.text =  "" //"Tin tức"
//        case 1:
//            headerView?.nameHeader.text = "" //"Dự án"
//        case 2:
//            headerView?.nameHeader.text = "" //"Bất động sản"
//        default:
//            return headerView
//        }
//        return headerView
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        switch indexPath.section
//        {
//        case 0:
//            let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
//            let vcDetail = storyboard.instantiateViewController(withIdentifier: "DetailNewsViewController") as? DetailNewsViewController
//            vcDetail?.news = self.listData.listNews[indexPath.row]
//            self.pushViewController(viewController: vcDetail)
//        case 1:
//            let storyboard = UIStoryboard(name: "Projects", bundle: nil)
//            let showDetail = storyboard.instantiateViewController(withIdentifier: "DetailProjectViewController") as? DetailProjectViewController
//            showDetail?.project = self.listData.listProjects[indexPath.row]
//            self.pushViewController(viewController: showDetail)
//        case 2:
        if self.listData.listBDS.count > indexPath.row
        {
            let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
            let showDetail = storyboard.instantiateViewController(withIdentifier: "DetailLanforSaleViewController") as? DetailLanforSaleViewController
            showDetail?.landForSale = Util.shared.listBDS[indexPath.row]
            showDetail?.landForSale.isLike = true
            self.pushViewController(viewController: showDetail)
        }
//        default:
//           break
//        }
    }
}

extension NewsLikeViewController:LandForSaleViewCellDelegate
{
    func deleteSaveNews(_ cell: LandForSaleViewCell, news: NewsModel, index: Int,type:Int) {
        self.showHUD("")
        APIClient.shared.cancelNews(id: news.id, type: type).asObservable().bind(onNext: { result in
            self.hideHUD()
            self.updateRow(item: news, index: index,type: type)
        }).disposed(by: self.disposeBag)
    }
    func deleteSaveLand(_ cell: LandForSaleViewCell, land: LandSaleModel, index: Int, type: Int) {
         self.showHUD("")
        APIClient.shared.cancelNews(id: land.id, type: type).asObservable().bind(onNext: { result in
            self.hideHUD()
            self.updateRowLand(item:land, index: index, type: type)
        }).disposed(by: self.disposeBag)
    }
    
    func deleteSaveProject(_ cell: LandForSaleViewCell, project: ProjectsModel, index: Int, type: Int) {
        self.showHUD("")
        APIClient.shared.cancelNews(id: project.id, type: type).asObservable().bind(onNext: { result in
            self.hideHUD()
            self.updateRowProject(item: project, index: index, type: type)
        }).disposed(by: self.disposeBag)
       
    }
    
    func updateRow(item: NewsModel!,index:Int,type:Int)
    {
        if index >= 0 {
            if type == 1
            {
                self.listData.listNews.remove(at: index)
            }
            let indexPath = NSIndexPath(row: index, section: 0)
            var arrayIndext: [NSIndexPath] = []
            arrayIndext.append(indexPath)
            self.tbaleView.beginUpdates()
            self.tbaleView.deleteRows(at: arrayIndext as [IndexPath], with: UITableViewRowAnimation.fade)
            self.tbaleView.endUpdates()
            
        }
        
    }
    func updateRowProject(item: ProjectsModel!,index:Int,type:Int)
    {
        if index >= 0 {
           
            if type == 2
            {
                self.listData.listProjects.remove(at: index)
            }
            let indexPath = NSIndexPath(row: index, section: 1)
            var arrayIndext: [NSIndexPath] = []
            arrayIndext.append(indexPath)
            self.tbaleView.beginUpdates()
            self.tbaleView.deleteRows(at: arrayIndext as [IndexPath], with: UITableViewRowAnimation.fade)
            self.tbaleView.endUpdates()
            
        }
        
    }
    func updateRowLand(item: LandSaleModel!,index:Int,type:Int)
    {
        if index >= 0 {
            if index >  Util.shared.listBDS.count - 1 {
                Util.shared.listBDS.removeAll()
                self.tbaleView.reloadData()
                return
            }
            Util.shared.listBDS.remove(at: index)
            
            let indexPath = NSIndexPath(row: index, section: 0)
            var arrayIndext: [NSIndexPath] = []
            arrayIndext.append(indexPath)
            self.tbaleView.beginUpdates()
            self.tbaleView.deleteRows(at: arrayIndext as [IndexPath], with: UITableViewRowAnimation.fade)
            self.tbaleView.endUpdates()
          
        }
        
    }
}
