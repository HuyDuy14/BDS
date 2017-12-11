//
//  ContainerViewController.swift
//  CallDocter
//
//  Created by DevOminext on 5/26/17.
//  Copyright © 2017 HuyDuy. All rights reserved.
//

import UIKit

class ContainerViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func resgisterButtonDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        let singUp = storyboard.instantiateViewController(withIdentifier: "ContainerSingUpViewController") as! ContainerSingUpViewController
        singUp.loginController = self
        self.pushViewController(viewController: singUp)
    }
}
