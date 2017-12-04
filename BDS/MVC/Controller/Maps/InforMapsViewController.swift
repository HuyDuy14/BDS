//
//  InforMapsViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/1/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class InforMapsViewController: BaseViewController {

    @IBOutlet weak var numberNews: UILabel!
    @IBOutlet var topSeparatorView: UIView!
   
    @IBOutlet var headerSectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    weak var currenviewController: UIViewController?
    
    var controller:LandForSaleViewController!
    let fullView: CGFloat = 100
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - 100
    }

    
    fileprivate var drawerBottomSafeArea: CGFloat = 0.0 {
        didSet {
            self.loadViewIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let showView = storyboard.instantiateViewController(withIdentifier: "LandForSaleViewController") as? LandForSaleViewController
        self.controller = showView
        showView?.isShowHeader = false
        self.showController(controllerName: "LandForSaleViewController", controller: showView)
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(InforMapsViewController.panGesture))
        gesture.delegate = self
        view.addGestureRecognizer(gesture)
        self.roundViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBackgroundView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            let frame = self?.view.frame
            let yComponent = self?.partialView
            self?.view.frame = CGRect(x: 0, y: yComponent!, width: frame!.width, height: frame!.height - 100)
        })
    }
    
    func roundViews() {
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
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
    
    func panGesture(_ recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        let velocity = recognizer.velocity(in: self.view)
        
        let y = self.view.frame.minY
        if (y + translation.y >= fullView) && (y + translation.y <= partialView) {
            self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        
        if recognizer.state == .ended {
            var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
            
            duration = duration > 1.3 ? 1 : duration
            
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                if  velocity.y >= 0 {
                    self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
                } else {
                    self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
                }
                
            }, completion: { [weak self] _ in
                if ( velocity.y < 0 ) {
                    self?.controller.tableView.isScrollEnabled = true
                }
            })
        }
    }
    
    
    func prepareBackgroundView(){
        let blurEffect = UIBlurEffect.init(style: .dark)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)
        visualEffect.frame = UIScreen.main.bounds
        bluredView.frame = UIScreen.main.bounds
        view.insertSubview(bluredView, at: 0)
    }
}

extension InforMapsViewController: UIGestureRecognizerDelegate {
    
    // Solution
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        let gesture = (gestureRecognizer as! UIPanGestureRecognizer)
        let direction = gesture.velocity(in: view).y
        
        let y = view.frame.minY
        if (y == fullView && self.controller.tableView.contentOffset.y == 0 && direction > 0) || (y == partialView) {
            self.controller.tableView.isScrollEnabled = false
        } else {
            self.controller.tableView.isScrollEnabled = true
        }
        
        return false
    }
    
}

