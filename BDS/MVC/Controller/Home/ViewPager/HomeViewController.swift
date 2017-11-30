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
    
    var listImage: [String] = ["icon_Content_off","icon_friend_off","icon_chat_off","icon_calendar_on",]
    var listImageOff: [String] = ["icon_Content_on","icon_friend_on","icon_chat_on","icon_calendar_off"]

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
        for i in 0..<4
        {
            if i == 0
            {
                self.imageMenu[i].image =  UIImage(named: self.listImageOff[i])
            } else {
                self.imageMenu[i].image =  UIImage(named: self.listImage[i])
            }
        }

    }
    @IBAction func btn1(_ sender: Any) {
        self.tutorialPageViewController?.scrollToViewController(index: 1)
        for i in 0..<4
        {
            if i == 1
            {
                self.imageMenu[i].image =  UIImage(named: self.listImageOff[i])
            } else {
                self.imageMenu[i].image =  UIImage(named: self.listImage[i])
            }
        }
    }

    @IBAction func btn2(_ sender: Any) {
        self.tutorialPageViewController?.scrollToViewController(index: 2)
        for i in 0..<4
        {
            if i == 2
            {
                self.imageMenu[i].image =  UIImage(named: self.listImageOff[i])
            } else {
                self.imageMenu[i].image =  UIImage(named: self.listImage[i])
            }
        }    }
    @IBAction func btn3(_ sender: Any) {
        self.tutorialPageViewController?.scrollToViewController(index: 3)
        for i in 0..<4
        {
            if i == 3
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
        for i in 0..<4
        {
            if i == index
            {
                self.imageMenu[i].image =  UIImage(named: self.listImageOff[i])
            } else {
                self.imageMenu[i].image =  UIImage(named: self.listImage[i])
            }
        }
        
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

