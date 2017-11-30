//
//  ContainerViewController.swift
//  CallDocter
//
//  Created by DevOminext on 5/26/17.
//  Copyright © 2017 HuyDuy. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewWillLayoutSubviews() {
        self.view.layoutIfNeeded()

    }
}
