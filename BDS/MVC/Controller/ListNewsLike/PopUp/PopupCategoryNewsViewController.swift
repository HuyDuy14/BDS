//
//  PopupCategoryNewsViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/1/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class PopupCategoryNewsViewController: BaseViewController {

    var finish:((_ index:Int)->Void)?
    var listName:[String] = ["Tin bất động sản","Tin xã hội","Tin giải trí","Tin kinh tế","Tin khám phá","Tin sức khoẻ"]
    
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
        cell.nameCell.text = self.listName[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.finish!(indexPath.row)
        self.dismiss(animated: true, completion: nil)
    }
}
