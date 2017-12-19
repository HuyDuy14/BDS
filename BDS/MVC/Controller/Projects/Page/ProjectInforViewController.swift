//
//  ProjectInforViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/19/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class ProjectInforViewController: BaseViewController {
    
    @IBOutlet var viewColor: [UIView]!
    @IBOutlet var textColor: [UILabel]!
    @IBOutlet weak var containerView: UIView!
    
    //Page
     weak var currenviewController: UIViewController?
    var projectPageViewController: InforProjectViewController?
    var pageController:InforProjectViewController?
    override func viewDidLoad() {
        super.viewDidLoad()

        let storyboard = UIStoryboard(name: "Projects", bundle: nil)
        let showView = storyboard.instantiateViewController(withIdentifier: "InforProjectViewController") as? InforProjectViewController
        self.pageController = showView
        showView?.imageDelegate = self
        self.projectPageViewController = showView
         self.showController(controllerName: "InforProjectViewController", controller: showView)
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
    
    @IBAction func backViewController(_ sender: Any) {
        Util.shared.projectsDetail = nil
        self.popToView()
    }
    
    @IBAction func sharedButtonDidTap(_ sender: Any) {
         AppDelegate.shared?.shareImage(controller: self, link: API.linkImage + "p" + Util.shared.projectsDetail.alias + "-" + Util.shared.projectsDetail.id + ".html", image: #imageLiteral(resourceName: "demo"))
    }
    
    @IBAction func showMapsViewController(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Projects", bundle: nil)
        let showDetail = storyboard.instantiateViewController(withIdentifier: "DetailMapsViewController") as? DetailMapsViewController
        showDetail?.project = Util.shared.projectsDetail
        self.pushViewController(viewController: showDetail)
    }
    
    @IBAction func inforProjectButtonDidTap(_ sender: Any) {
        self.pageController?.scrollToViewController(index: 0)
        for i in 0..<3
        {
            if i == 0
            {
                self.viewColor[i].backgroundColor = UIColor(netHex:0x19846B)
                self.textColor[i].textColor = UIColor.white
            }
            else
            {
                self.viewColor[i].backgroundColor = UIColor(netHex:0xF2F2F2)
                self.textColor[i].textColor = UIColor(netHex:0x19846B)
            }
        }
    }
    
    @IBAction func localtionProjectButtonDidTap(_ sender: Any) {
        self.pageController?.scrollToViewController(index: 1)
        for i in 0..<3
        {
            if i == 1
            {
                self.viewColor[i].backgroundColor = UIColor(netHex:0x19846B)
                self.textColor[i].textColor = UIColor.white
            }
            else
            {
                self.viewColor[i].backgroundColor = UIColor(netHex:0xF2F2F2)
                self.textColor[i].textColor = UIColor(netHex:0x19846B)
            }
        }
    }
    
    @IBAction func inforCompanyButtonDidTap(_ sender: Any) {
        self.pageController?.scrollToViewController(index: 2)
        for i in 0..<3
        {
            if i == 2
            {
                self.viewColor[i].backgroundColor = UIColor(netHex:0x19846B)
                self.textColor[i].textColor = UIColor.white
            }
            else
            {
                self.viewColor[i].backgroundColor = UIColor(netHex:0xF2F2F2)
                self.textColor[i].textColor = UIColor(netHex:0x19846B)
            }
        }
    }
    
}
extension ProjectInforViewController: InforProjectViewControllerDelegate {
    func imagePageViewController(_ imagePageViewController: InforProjectViewController, didUpdatePageCount count: Int) {
        
    }
    
    func imagePageViewController(_ imagePageViewController: InforProjectViewController, didUpdatePageIndex index: Int) {
       
    }
    
}
