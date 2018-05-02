//
//  RightMenuViewController.swift
//  CallDocter
//
//  Created by DevOminext on 5/22/17.
//  Copyright © 2017 HuyDuy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class RightMenuViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var username: UILabel!

    let disposeBag = DisposeBag()
    var listDataMenu: [ItemMenuObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingMenu()
        self.initDataMenu()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.layoutIfNeeded()
        self.username.text = Util.shared.currentUser.username
        self.view.endEditing(true)
    }

    func settingMenu() {
        self.navigationController?.isNavigationBarHidden = true
        SideMenuManager.menuFadeStatusBar = false
        SideMenuManager.menuPresentMode = .menuSlideIn
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }
    
    override func viewWillLayoutSubviews() {
        self.view.layoutIfNeeded()
       
    }
   
    func initDataMenu() {
 
            listDataMenu = [
                ItemMenuObject(id: 0, nameMenu: "Home", image: "icon_next"),ItemMenuObject(id: 1, nameMenu: "Nhà đất bán", image: "icon_next"),ItemMenuObject(id: 2, nameMenu: "Nhà đất cho thuê", image: "icon_next"), ItemMenuObject(id: 3, nameMenu: "Tìm môi giới", image: "icon_next"), ItemMenuObject(id: 4, nameMenu: "Dự án", image: "icon_next"), ItemMenuObject(id: 5, nameMenu: "Tin tức", image: "icon_next"), ItemMenuObject(id: 6, nameMenu: "Đăng ký nhận tin rao", image: "icon_next"),ItemMenuObject(id: 7, nameMenu: "Về chúng tôi", image: "icon_next")]
       
    
        let listDataInit = Observable.just(listDataMenu)
        listDataInit.asObservable().bind(to: self.tableView.rx.items(cellIdentifier: "ItemViewCellMenu")) { (row, item: ItemMenuObject, cell: ItemViewCellMenu) in
            cell.initData(item)
        }.disposed(by: disposeBag)
        
        self.tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
             switch (self.listDataMenu[indexPath.row].id)
             {
                case 0:
                    SideMenuTransition.hideMenu()
                case 1:
                    SaveCurrentVC.shared.homeController?.tutorialPageViewController?.scrollToViewController(index: 3)
                    SideMenuTransition.hideMenu()
                case 2:
                    SaveCurrentVC.shared.homeController?.tutorialPageViewController?.scrollToViewController(index: 1)
                    SideMenuTransition.hideMenu()
                case 3:
                    let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
                    let searchView = storyboard.instantiateViewController(withIdentifier: "SearchContactViewController") as? SearchContactViewController
                    self.pushViewController(viewController: searchView!)
                    SideMenuTransition.hideMenu()
                 case 4:
                    let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
                    let searchView = storyboard.instantiateViewController(withIdentifier: "SearchProjectsViewController") as? SearchProjectsViewController
                    self.pushViewController(viewController: searchView!)
                    SideMenuTransition.hideMenu()
                 case 5:
                    let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
                    let newsController = storyboard.instantiateViewController(withIdentifier: "NewsViewController") as? NewsViewController
                    newsController?.isNews = true
                    self.pushViewController(viewController: newsController!)
                    SideMenuTransition.hideMenu()
                 case 6:
                    let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
                    let newsController = storyboard.instantiateViewController(withIdentifier: "RegisterNewsViewController") as? RegisterNewsViewController
                    self.pushViewController(viewController: newsController!)
                    SideMenuTransition.hideMenu()
                 case 7:
                    let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
                    let searchView = storyboard.instantiateViewController(withIdentifier: "InforAppViewController") as? InforAppViewController
                    self.pushViewController(viewController: searchView!)
                    SideMenuTransition.hideMenu()
                    default:
                    SideMenuTransition.hideMenu()
                    
             }
            }).disposed(by: self.disposeBag)
    }

    @IBAction func showInforUserButtonDidTap(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "User", bundle: nil)
        let showUser = InforUserViewController()
        self.pushViewController(viewController: showUser)
        SideMenuTransition.hideMenu()
    }
    @IBAction func loguotButtonDidTap(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Bạn muốn thoát khỏi app?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            UserDefaults.standard.set("", forKey: FBID)
            UserDefaults.standard.set("", forKey: FBNAME)
            UserDefaults.standard.set("", forKey: USERNAME)
            UserDefaults.standard.set("", forKey: PASSWORD)
            UserDefaults.standard.set("", forKey: GGID)
            UserDefaults.standard.set("", forKey: GGEMAIL)
            UserDefaults.standard.set("", forKey: GGNAME)
            Util.shared.currentUser = UserModel()
//            AppDelegate.shared?.setLoginRootViewControoler()
            SideMenuTransition.hideMenu()
            
        }))
        
      
    }
    
    
    
}

