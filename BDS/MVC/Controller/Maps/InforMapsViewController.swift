//
//  InforMapsViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/1/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import Pulley

class InforMapsViewController: BaseViewController {

    @IBOutlet var topSeparatorView: UIView!
   
    @IBOutlet var headerSectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    weak var currenviewController: UIViewController?
    
    fileprivate var drawerBottomSafeArea: CGFloat = 0.0 {
        didSet {
            self.loadViewIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let showView = storyboard.instantiateViewController(withIdentifier: "LandForSaleViewController") as? LandForSaleViewController
        showView?.isShowHeader = false
        self.showController(controllerName: "LandForSaleViewController", controller: showView)

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

extension InforMapsViewController: PulleyDrawerViewControllerDelegate {
    func collapsedDrawerHeight() -> CGFloat {
        return 50
    }
    
    func partialRevealDrawerHeight() -> CGFloat {
         return 264.0
    }
    
    func supportedDrawerPositions() -> [PulleyPosition] {
        return PulleyPosition.all
    }
    

    func drawerPositionDidChange(drawer: PulleyViewController, bottomSafeArea: CGFloat)
    {
      
        drawerBottomSafeArea = bottomSafeArea
        
        if drawer.drawerPosition == .collapsed
        {
            headerSectionHeightConstraint.constant = 68.0 + drawerBottomSafeArea
        }
        else
        {
            headerSectionHeightConstraint.constant = 68.0
        }
    
      
    }
    
    func drawerDisplayModeDidChange(drawer: PulleyViewController) {
        
       
    }
}

