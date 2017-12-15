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
        SaveCurrentVC.shared.homeController.tutorialPageViewController?.scrollToViewController(index: 3)
    }
    
    
    @IBAction func registerNewsButtonDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
        let newsController = storyboard.instantiateViewController(withIdentifier: "RegisterNewsViewController") as? RegisterNewsViewController
        self.pushViewController(viewController: newsController!)
    }
    
    @IBAction func landForRentButtonDidTap(_ sender: Any) {
        SaveCurrentVC.shared.homeController.tutorialPageViewController?.scrollToViewController(index: 1)

    }
    
    @IBAction func asviceButtonDidTap(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
        let newsController = storyboard.instantiateViewController(withIdentifier: "NewsViewController") as? NewsViewController
        newsController?.isNews = false
        self.pushViewController(viewController: newsController!)
        
    }
    
    
}
