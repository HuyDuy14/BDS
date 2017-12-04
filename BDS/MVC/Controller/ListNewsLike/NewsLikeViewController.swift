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

    @IBOutlet weak var tbaleView: UITableView!
    var refreshControl: UIRefreshControl!
    let disposeBag = DisposeBag()
    var listData:[NewsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbaleView.delegate = self
        self.tbaleView.dataSource = self
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl?.addTarget(self, action: #selector(NewsLikeViewController.refresh(_:)), for: UIControlEvents.valueChanged)
        self.tbaleView.addSubview(refreshControl!)
    
        self.getDataNews()
    }
    
    func refresh(_ sender: Any) {
        self.listData = []
        self.getDataNews()
    }
    
    func getDataNews()
    {
        Util.shared.listNewsSave = []
        APIClient.shared.getNewsSave().asObservable().bind(onNext: { result in
            for data in result.dataArray {
                if let dic = data as? [String:Any] {
                    let newsModel = NewsModel(JSON: dic)
                    Util.shared.listNewsSave.append(newsModel!)
                }
            }
            self.listData =  Util.shared.listNewsSave
            DispatchQueue.main.async {
                self.tbaleView.reloadData()
            }
            self.refreshControl.endRefreshing()
            self.hideHUD()
        }).disposed(by: self.disposeBag)
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        SaveCurrentVC.shared.homeController.tutorialPageViewController?.scrollToViewController(index: 0)
    }
    

}
extension NewsLikeViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.listData.count > indexPath.row {
            let cell = self.tbaleView.dequeueReusableCell(withIdentifier: "NewsLikeViewCell") as! LandForSaleViewCell
            cell.loadDataNewsCell(cell: self.listData[indexPath.row], index: indexPath.row)
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.listData.count > indexPath.row
        {
            let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
            let vcDetail = storyboard.instantiateViewController(withIdentifier: "DetailNewsViewController") as? DetailNewsViewController
            vcDetail?.news = self.listData[indexPath.row]
            self.pushViewController(viewController: vcDetail)
        }
    }
}

extension NewsLikeViewController:LandForSaleViewCellDelegate
{
    func deleteSaveNews(_ cell: LandForSaleViewCell, news: NewsModel, index: Int) {
        self.showHUD("")
        APIClient.shared.cancelNews(id: news.id).asObservable().bind(onNext: { result in
            self.hideHUD()
            self.updateRow(item: news, index: index)
        }).disposed(by: self.disposeBag)
    }
    
    func updateRow(item: NewsModel!,index:Int)
    {
        if index >= 0 {
            let indexPath = NSIndexPath(row: index, section: 0)
            var arrayIndext: [NSIndexPath] = []
            arrayIndext.append(indexPath)
            self.tbaleView.beginUpdates()
            self.tbaleView.deleteRows(at: arrayIndext as [IndexPath], with: UITableViewRowAnimation.fade)
            self.tbaleView.endUpdates()
        }
        
    }
}
