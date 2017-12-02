//
//  ContainerSingUpViewController.swift
//  Docter
//
//  Created by Huy Duy on 6/23/17.
//  Copyright © 2017 huy. All rights reserved.
//

import UIKit


class ContainerSingUpViewController: BaseViewController {

    @IBOutlet weak var cotainerView: UIView!
    @IBOutlet weak var headerView: HeaderViewController!
    weak var currenviewController: UIViewController?
  
    var isResetPass:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

            
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        let showView = storyboard.instantiateViewController(withIdentifier: "SingUpViewController") as? SingUpViewController
        self.showController(controllerName: "SingUpViewController", controller: showView)
      
    }
    
    func showController(controllerName: String, controller: UIViewController?)
    {
        self.currenviewController = controller
        let frame = cotainerView.frame
        controller!.view.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        let navigationController = UINavigationController(rootViewController: controller!)
        navigationController.view.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        navigationController.isNavigationBarHidden = true
        self.addChildViewController(navigationController)
        self.cotainerView.addSubview(navigationController.view)
    }

    @IBAction func closeButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
