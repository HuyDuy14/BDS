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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl?.addTarget(self, action: #selector(NewsViewController.refresh(_:)), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refreshControl!)
        self.showHUD("")
        self.getData()
        
    }
    
    func refresh(_ sender: Any) {
        self.listData = []
        self.getData()
    }
    
    // MARK : - Get Data
    func getData()
    {
        APIClient.shared.getNews(id: "11").asObservable().bind(onNext: { result in
            for data in result.dataArray {
                if let dic = data as? [String:Any] {
                    let newsModel = NewsModel(JSON: dic)
                    self.listData.append(newsModel!)
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            self.refreshControl.endRefreshing()
            self.hideHUD()
        }).disposed(by: self.disposeBag)
    }

    @IBAction func backButtonDidTap(_ sender: Any) {
        self.popToView()
    }
    
    @IBAction func selectCategoryButtonDidTap(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
        let vcCategory = storyboard.instantiateViewController(withIdentifier: "PopupCategoryNewsViewController") as? PopupCategoryNewsViewController
        vcCategory?.finish = { index in
            print(index)
        }
        vcCategory?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        vcCategory?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(vcCategory!, animated: true, completion: nil)
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
extension NewsViewController:NewsViewCellDelegate
{
    func saveNews(_ cell: NewsViewCell, news: NewsModel,index:Int) {
        
        self.showHUD("")
        APIClient.shared.saveNews(id: news.id).asObservable().bind(onNext: { result in
            self.showAlert("Lưu tin thành công")
            self.hideHUD()
        }).disposed(by: self.disposeBag)
    }
}
