//
//  HomeViewController.swift
//  CallDocter
//
//  Created by DevOminext on 5/22/17.
//  Copyright © 2017 HuyDuy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet var imageMenu: [UIImageView]!
    
    var listImage: [String] = ["icon_home_off","icon_tax_off","icon_map_off","icon_cell_off","icon_off"]
    var listImageOff: [String] = ["icon_menu_home_on","icon_tax_on","icon_map_on","icon_cell_on","icon_on"]

    var index: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    var tutorialPageViewController: TutorialPageViewController? {
        didSet {
            tutorialPageViewController?.tutorialDelegate = self
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tutorialPageViewController = segue.destination as? TutorialPageViewController {
            self.tutorialPageViewController = tutorialPageViewController
        }
    }

    @IBAction func btn0(_ sender: Any) {
    self.tutorialPageViewController?.scrollToViewController(index: 0)
       self.setImagePage(index: 0)
    }
    @IBAction func btn1(_ sender: Any) {
    self.tutorialPageViewController?.scrollToViewController(index: 1)
       self.setImagePage(index: 1)
    }

    @IBAction func btn2(_ sender: Any) {
    self.tutorialPageViewController?.scrollToViewController(index: 2)
        self.setImagePage(index: 2)
    }
    
    @IBAction func btn3(_ sender: Any) {
    self.tutorialPageViewController?.scrollToViewController(index: 3)
        self.setImagePage(index: 3)
       
    }
    @IBAction func btn4(_ sender: Any) {
    self.tutorialPageViewController?.scrollToViewController(index: 4)
        self.setImagePage(index: 4)
    }
    
    func setImagePage(index:Int)
    {
        for i in 0..<5
        {
            if i == index
            {
                self.imageMenu[i].image =  UIImage(named: self.listImageOff[i])
            } else {
                self.imageMenu[i].image =  UIImage(named: self.listImage[i])
            }
        }
    }
    
    @IBAction func acctionCallView(_ sender: Any) {

    }

}

extension HomeViewController: TutorialPageViewControllerDelegate {

    func tutorialPageViewController(_ tutorialPageViewController: TutorialPageViewController,
                                    didUpdatePageCount count: Int) {

    }

    func tutorialPageViewController(_ tutorialPageViewController: TutorialPageViewController,
                                    didUpdatePageIndex index: Int) {
        self.setImagePage(index: index)
        
    }

    func setTitleView(index:Int){
        switch index {
        case 0:
            self.titleView.text = "Danh sách dịch vụ"
        case 1:
            self.titleView.text = "Danh sách công việc"
        case 2:
            self.titleView.text = "Trang cá nhân"
        default:()
            
        }
    }
}

