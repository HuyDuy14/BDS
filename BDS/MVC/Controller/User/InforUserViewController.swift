//
//  InforUserViewController.swift
//  BDS
//
//  Created by Duy Huy on 11/30/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class InforUserViewController: BaseViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var headerView: HeaderViewController!
     weak var currenviewController: UIViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SaveCurrentVC.shared.inforUserVC = self
        self.headerView.delegate = self
        self.headerView.setTitleView(title: "Thông tin cá nhân", infor: "Cập nhật thông tin cá nhân")
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        let showView = storyboard.instantiateViewController(withIdentifier: "EditInforUserViewController") as? EditInforUserViewController
        self.showController(controllerName: "EditInforUserViewController", controller: showView)
    }
    
    deinit {
        print("ad")
    }

    func showController(controllerName: String, controller: UIViewController?)
    {
        self.currenviewController = controller
        let frame = containerView.frame
        controller!.view.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        let navigationController = UINavigationController(rootViewController: controller!)
        navigationController.view.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        navigationController.isNavigationBarHidden = true
        self.addChildViewController(navigationController)
        self.containerView.addSubview(navigationController.view)
    }
    

}
