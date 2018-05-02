//
//  HomeMenuViewController.swift
//  BDS
//
//  Created by Duy Huy on 11/30/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class HomeMenuViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searhContactButtonDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
        let searchView = storyboard.instantiateViewController(withIdentifier: "SearchContactViewController") as? SearchContactViewController
        self.pushViewController(viewController: searchView!)
    }
    
    @IBAction func searchProjectsButtonDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
        let searchView = storyboard.instantiateViewController(withIdentifier: "SearchProjectsViewController") as? SearchProjectsViewController
        self.pushViewController(viewController: searchView!)

    }
    
    @IBAction func newsButtonDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
        let newsController = storyboard.instantiateViewController(withIdentifier: "NewsViewController") as? NewsViewController
        newsController?.isNews = true
        self.pushViewController(viewController: newsController!)
    }
    
    @IBAction func searchLandForSaleButtonDidTap(_ sender: Any) {
        SaveCurrentVC.shared.homeController?.tutorialPageViewController?.scrollToViewController(index: 3)
    }
    
    
    @IBAction func registerNewsButtonDidTap(_ sender: Any) {
        if Util.shared.currentUser.id.count == 0
        {
            AppDelegate.shared?.setLoginRootViewControoler()
            return
        }
        let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
        let newsController = storyboard.instantiateViewController(withIdentifier: "RegisterNewsViewController") as? RegisterNewsViewController
        self.pushViewController(viewController: newsController!)
    }
    
    @IBAction func landForRentButtonDidTap(_ sender: Any) {
        SaveCurrentVC.shared.homeController?.tutorialPageViewController?.scrollToViewController(index: 1)

    }
    
    @IBAction func asviceButtonDidTap(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
        let newsController = storyboard.instantiateViewController(withIdentifier: "NewsViewController") as? NewsViewController
        newsController?.isNews = false
        self.pushViewController(viewController: newsController!)
        
    }
    
    @IBAction func postNewsButtonDidTap(_ sender: Any) {
        if Util.shared.currentUser.id.count == 0
        {
            AppDelegate.shared?.setLoginRootViewControoler()
            return
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let postNews = storyboard.instantiateViewController(withIdentifier: "NewsLikeViewController") as! NewsLikeViewController
        postNews.isMenu = true
        self.pushViewController(viewController: postNews)
    }
    
    @IBAction func showPostsNewsButtonDidTap(_ sender: Any) {
        if Util.shared.currentUser.id.count == 0
        {
            AppDelegate.shared?.setLoginRootViewControoler()
            return
        }
        let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
        let postNews = storyboard.instantiateViewController(withIdentifier: "PostNewsViewController") as! PostNewsViewController
        self.pushViewController(viewController: postNews)
       
    }
    
    @IBAction func loguotButtonDidTap(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Bạn muốn thoát khỏi app?", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { _ in
            UserDefaults.standard.set("", forKey: FBID)
            UserDefaults.standard.set("", forKey: FBNAME)
            UserDefaults.standard.set("", forKey: USERNAME)
            UserDefaults.standard.set("", forKey: PASSWORD)
            UserDefaults.standard.set("", forKey: GGID)
            UserDefaults.standard.set("", forKey: GGEMAIL)
            UserDefaults.standard.set("", forKey: GGNAME)
            
            Util.shared.currentUser = UserModel()
            SideMenuTransition.hideMenu()
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
