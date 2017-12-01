//
//  BaseViewController.swift
//  CallDocter
//
//  Created by DevOminext on 5/22/17.
//  Copyright © 2017 HuyDuy. All rights reserved.
//

import UIKit
import ACProgressHUD
import UIAlertView_Blocks

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func navigation() {
        self.navigationBar?.backgroundColor = COLOR_NAVI
        self.navigationBar?.barTintColor = COLOR_NAVI
        self.navigationBar?.tintColor = UIColor.white
        self.navigationBar?.isTranslucent = false
        self.navigationBar?.tintColor = UIColor.white
    }
    
    func setTitleNavigation(title:String){
        self.navigationItem.title = title
        self.navigationBar?.tintColor = UIColor.white
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
    }
    func setTitleBackButton(title:String) {
        //        self.navigationController?.navigationBar.topItem!.title = title.localized()
        self.navigationItem.backBarButtonItem?.title = title
    }
    
    func setLeftNVWithImage(imgname:UIImage, action selector: Selector) {
        let button:UIButton = UIButton.init(type: .custom)
        button.setBackgroundImage(imgname, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.sizeToFit()
        button.isExclusiveTouch = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: button)
    }
    func setNameRightMenu(name:String, action selector: Selector){
        let button = UIButton.init(type: .custom)
        button.setTitle(name, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.sizeToFit()
        button.isExclusiveTouch = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)
    }
    
    func setRightNVWithImage (imgname: UIImage, action selector: Selector) {
        let button = UIButton.init(type: .custom)
        button.setBackgroundImage(imgname, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.sizeToFit()
        button.isExclusiveTouch = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)
    }
    func setRightWithMenu(imgname:UIImage, action selector:Selector){
        let button:UIButton = UIButton.init(type: .custom)
        button.setBackgroundImage(imgname, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.sizeToFit()
        button.isExclusiveTouch = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)
    }
    
    func setTitleNavigation(title:String, color:UIColor){
        self.navigationItem.title = title
        self.navigationBar?.tintColor = UIColor.white
        self.navigationBar?.titleTextAttributes = [NSForegroundColorAttributeName: color,NSFontAttributeName: UIFont(name: "GenJyuuGothic-P-Bold", size: 20)!]
    }
    
    func hiddenNavBar(hidden: Bool) {
        self.navigationController?.setNavigationBarHidden(hidden, animated: false)
    }
    
    func pushViewController(viewController:UIViewController!){
        if viewController == nil {return}
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showMenuView()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let menuview = storyboard.instantiateViewController(withIdentifier: "UISideMenuNavigationController") as? UISideMenuNavigationController
        self.present(menuview!, animated: true, completion: nil)
    }

}

extension BaseViewController: HeaderViewControllerDelegate {
    func basicHeaderViewDidTouchButtonLeft() {
        print("search")
    }

    func basicHeaderViewDidTouchButtonClose() {
       
        _ = self.navigationController?.popViewController(animated: true)

    }
}
public extension UIViewController {
    
    /// SwifterSwift: Check if ViewController is onscreen and not hidden.
    public var isVisible: Bool {
        // http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
        return self.isViewLoaded && view.window != nil
    }
    
    /// SwifterSwift: NavigationBar in a ViewController.
    public var navigationBar: UINavigationBar? {
        return navigationController?.navigationBar
    }
    func showHUD(_ message: String) {
        ACProgressHUD.showLoading(withCustomMessage: message)
    }
    
    func hideHUD() {
        ACProgressHUD.hide()
    }
    
    func showAlert(_ message: String) {
        _ = UIAlertView.show(withTitle: "", message: message, cancelButtonTitle: "OK", otherButtonTitles: nil, tap: nil)
    }
    
    func popToView() {
        self.navigationController?.popViewController(animated: true)
    }

    
}

