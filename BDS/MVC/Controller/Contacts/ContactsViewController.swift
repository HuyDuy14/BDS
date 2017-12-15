//
//  ContactsViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/1/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ContactsViewController: BaseViewController {

    @IBOutlet weak var headerView: HeaderViewController!
    @IBOutlet weak var tableView: UITableView!
    
    var listData:[BrokerModel] = []
    var refreshControl: UIRefreshControl!
    
    var idProject:String = "null"
    var idType:String = "1"
    var idCity:String = "null"
    var idDistrict:String = "null"
    let disposeBag = DisposeBag()
    var page:Int = 0
    var isLoad: Bool = true
    var isLoading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.headerView.delegate = self
        self.headerView.setTitleView(title: "Danh bạ nhà môi giới", infor: "Danh sách tìm kiếm môi giới chuyên nghiệp")
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl?.addTarget(self, action: #selector(ContactsViewController.refresh(_:)), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refreshControl!)
        self.showHUD("")
        self.loadData(refresh: true)
    }
    
    func refresh(_ sender: Any) {
       self.listData = []
       self.page = 0
       self.loadData(refresh: false)
    }
    
    func loadData(refresh: Bool)
    {
        
        if self.isLoading == false {
            self.isLoading = true
            APIClient.shared.searchLanForSent(type: self.idType, idProject: self.idProject, idCity: self.idCity, idDistrict: self.idDistrict,page:self.page).asObservable().bind(onNext: { result in
                DispatchQueue.main.async {
                    var contacts: [BrokerModel] = []
                    for data in result.dataArray
                    {
                        if let dic = data as? [String:Any]
                        {
                            let contact = BrokerModel(JSON: dic)
                            contacts.append(contact!)
                        }
                    }
                    
                    if contacts.count == 0
                    {
                        self.isLoad = false
                    }
                    self.listData.append(contentsOf: contacts)
                    
                    if self.listData.count != 0 && refresh == true {
                        var array: [NSIndexPath]! = []
                        let index: Int = self.listData.count - contacts.count
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

   
}
extension ContactsViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.listData.count > indexPath.row {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "ContactViewCell") as! ContactViewCell
            cell.loadData(contact: self.listData[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.listData.count > indexPath.row {
            let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
            let detail = storyboard.instantiateViewController(withIdentifier: "DetailContactViewController") as? DetailContactViewController
            detail?.contact = self.listData[indexPath.row]
            self.pushViewController(viewController: detail!)
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        let end = scrollView.contentSize.height
        if self.listData.count >= 10  {
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

