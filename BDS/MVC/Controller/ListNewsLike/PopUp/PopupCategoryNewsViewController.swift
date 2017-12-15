//
//  PopupCategoryNewsViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/1/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class PopupCategoryNewsViewController: BaseViewController {

    var finish:((_ id:String)->Void)?
    var listName:[CategoryNewsModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    @IBAction func closeViewButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PopupCategoryNewsViewController:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "PopupCategoryNewsViewCell") as! PopupCategoryNewsViewCell
        cell.nameCell.text = self.listName[indexPath.row].name
//        cell.imageCell.setImageUrlNews(url: API.linkImage + self.listName[indexPath.row].icon)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        self.finish!( self.listName[indexPath.row].id)
        self.dismiss(animated: true, completion: nil)
    }
}
