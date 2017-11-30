//
//  BaseTableViewController.swift
//  CallDocter
//
//  Created by DevOminext on 5/22/17.
//  Copyright © 2017 HuyDuy. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
}
extension BaseTableViewController: HeaderViewControllerDelegate {
    func basicHeaderViewDidTouchButtonLeft() {
        print("search")
    }

    func basicHeaderViewDidTouchButtonClose() {
        _ = self.navigationController?.popViewController(animated: true)

    }
}

