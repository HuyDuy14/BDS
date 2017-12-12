//
//  NewsViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/1/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    let disposeBag = DisposeBag()
    var listData:[NewsModel] = []
    var idCategory:String = ""
    var page:Int = 0
    var isLoad: Bool = true
    var isLoading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl?.addTarget(self, action: #selector(NewsViewController.refresh(_:)), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refreshControl!)
        self.showHUD("")
        self.page = 0
        self.loadData(refresh: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getDataNews()
    }
    
    func showPopSelectCategory()
    {
        let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
        let vcCategory = storyboard.instantiateViewController(withIdentifier: "PopupCategoryNewsViewController") as? PopupCategoryNewsViewController
        vcCategory?.finish = { id in
            self.showHUD("")
            self.idCategory = id
            self.listData = []
            self.page = 0
            self.loadData(refresh: true)
        }
        vcCategory?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        vcCategory?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(vcCategory!, animated: true, completion: nil)
    }
    
    func refresh(_ sender: Any) {
        self.listData = []
        self.page = 0
        self.loadData(refresh: false)
    }
    
    // MARK : - Get Data
    
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
          
        }).disposed(by: self.disposeBag)
    }
    
    
    
    func loadData(refresh: Bool)
    {
        
        if self.isLoading == false {
            self.isLoading = true
            APIClient.shared.getNews(id:self.idCategory,page:self.page).asObservable().bind(onNext: {result in
                DispatchQueue.main.async {
                    var listNews: [NewsModel] = []
                    for data in result.dataArray
                    {
                        if let dic = data as? [String:Any]
                        {
                            let landSaleModel = NewsModel(JSON: dic)
                            listNews.append(landSaleModel!)
                        }
                    }
                    
                    if listNews.count == 0
                    {
                        self.isLoad = false
                    }
                    self.listData.append(contentsOf: listNews)
                    if self.listData.count != 0 && refresh == true {
                        var array: [NSIndexPath]! = []
                        let index: Int = self.listData.count - listNews.count
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
    

    @IBAction func backButtonDidTap(_ sender: Any) {
        self.popToView()
    }
    
    @IBAction func selectCategoryButtonDidTap(_ sender: Any) {
      self.showPopSelectCategory()
    }
}
extension NewsViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.listData.count > indexPath.row {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "NewsViewCell") as! NewsViewCell
            cell.loadDataCell(news: self.listData[indexPath.row],index: indexPath.row)
            if self.listData[indexPath.row].isLike == true
            {
                cell.btnSaveNews.tintColor = UIColor.red
            }
            else
            {
                cell.btnSaveNews.tintColor = UIColor.lightGray
            }
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
extension NewsViewController:NewsViewCellDelegate
{
    func shared(_ cell: NewsViewCell, news: NewsModel, index: Int) {
        AppDelegate.shared?.shareImage(controller: self, link: "", image: #imageLiteral(resourceName: "demo"))
    }
    
    func updateRow(item: NewsModel!, status: Bool,index:Int)
    {
        if index >= 0 {
            self.listData[index].isLike = status
            let indexPath = NSIndexPath(row: index, section: 0)
            var arrayIndext: [NSIndexPath] = []
            arrayIndext.append(indexPath)
            self.tableView.beginUpdates()
            self.tableView.reloadRows(at: arrayIndext as [IndexPath], with: UITableViewRowAnimation.fade)
            self.tableView.endUpdates()
        }
        
    }
    
    func saveNews(_ cell: NewsViewCell, news: NewsModel,index:Int) {
        
        self.showHUD("")
        if news.isLike == false
        {
            APIClient.shared.saveNews(id: news.id, type: 1).asObservable().bind(onNext: { result in
                self.hideHUD()
                self.updateRow(item: news, status: true, index: index)
            }).disposed(by: self.disposeBag)
        }
        else
        {
            APIClient.shared.cancelNews(id: news.id, type: 1).asObservable().bind(onNext: { result in
                self.hideHUD()
                self.updateRow(item: news, status: false, index: index)
            }).disposed(by: self.disposeBag)
        }
    }
}
