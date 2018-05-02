//
//  DetailProjectViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/5/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailProjectViewController: BaseViewController {

    @IBOutlet weak var imageProjects: UIImageView!
    @IBOutlet weak var nameUserProjects: UILabel!
    @IBOutlet weak var addressProject: UILabel!
    @IBOutlet weak var allAcreage: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var monney: UILabel!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var titleproject: UILabel!
    @IBOutlet weak var scaleProject: UILabel!
    
    var project:ProjectsModel! = ProjectsModel()
    let disposeBag = DisposeBag()
    var listTypePrice:[ModelPicker] = [ModelPicker(id: 0, name: "Thoả thuận"),ModelPicker(id: 1, name: "Triệu"),ModelPicker(id: 2, name: "Tỷ"),ModelPicker(id: 6, name: "Trăm nghìn/m2"),ModelPicker(id: 7, name: "Triệu/m2")]
    //Page Image
    weak var currenviewController: UIViewController?
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageController: UIPageControl!
    var imagePageViewController: ImagePageViewController?
    var timer:Timer!
    var indexPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.project.id = Util.shared.projectsIdDetail
        self.fillData()
        self.loadDataServer()
       
    }
    
    func updateStart() {
        indexPage += 1
        if indexPage >= self.project.list_image.count
        {
            indexPage = 0
        }
        self.imagePageViewController?.scrollToViewController(index: indexPage)
    }
    
    func loadDataServer()
    {
        self.showHUD("")
        APIClient.shared.getDetailProject(id: self.project.id).asObservable().bind(onNext: {result in
            self.project = ProjectsModel(JSON: result.data!)
            Util.shared.projectsDetail = self.project
            let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
            let showView = storyboard.instantiateViewController(withIdentifier: "ImagePageViewController") as? ImagePageViewController
            showView?.imageDelegate = self
            self.imagePageViewController = showView
            if self.project.list_image.count > 0
            {
                self.imageProjects.isHidden = true
            }
            self.timer =  Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.updateStart), userInfo: nil, repeats: true)
            self.pageController.numberOfPages = self.project.list_image.count
            showView?.listImageURL = self.project.list_image
            self.fillData()
            self.showController(controllerName: "ImagePageViewController", controller: showView)
            self.hideHUD()
            
        }).disposed(by: self.disposeBag)
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
    
    func fillData()
    {
        self.nameUserProjects.text = project.investor
        self.imageProjects.setImageProject(urlString: API.linkImage + project.image)
        self.addressProject.text = project.address
        self.titleproject.text = project.title
        if self.project.land_area == "0"
        {
            self.allAcreage.text = "Liên hệ"
        }
        else
        {
            self.allAcreage.text = self.project.land_area + "m2"
        }
        
        if  self.project.price.count == 0
        {
            self.monney.text = "Thoả thuận"
            return
        }
        self.monney.text  = self.project.price
        let array = self.project.price.components(separatedBy: " ")
        if array.count == 1
        {
            for item in self.listTypePrice
            {
                
                if String(item.id) ==  self.project.land_price_type
                {
                    self.monney.text = self.project.price + " " + item.name
                    return
                }
            }
        }
        self.date.text = project.date_finish.FromStringToDateToStringProjects()
        self.scaleProject.text = project.summary
        self.webView.loadHTMLString(Util.shared.htmlString(from: project.introduce), baseURL: nil)
        
    }
    

    // MARK: - UIAction
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.popToView()
    }
    
    @IBAction func showMapsButtonDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Projects", bundle: nil)
        let showDetail = storyboard.instantiateViewController(withIdentifier: "DetailMapsViewController") as? DetailMapsViewController
        showDetail?.project = self.project
        self.pushViewController(viewController: showDetail)
    }
    
    @IBAction func saveButtonDidTap(_ sender: Any) {
        if Util.shared.currentUser.id.count == 0
        {
            AppDelegate.shared?.setLoginRootViewControoler()
            return
        }
        self.showHUD("")
        if self.project.isLike == true
        {
            APIClient.shared.cancelNews(id: self.project.id, type: 2).asObservable().bind(onNext: { result in
                self.hideHUD()
                for i in 0..<(Util.shared.listProjectSave.count - 1)
                {
                    if Util.shared.listProjectSave[i].id == self.project.id
                    {
                        Util.shared.listProjectSave.remove(at: i)
                    }
                }
                self.project.isLike = false
              
            }).disposed(by: self.disposeBag)
        }
        else
        {
            APIClient.shared.saveNews(id: self.project.id, type: 2).asObservable().bind(onNext: { result in
                self.hideHUD()
                Util.shared.listProjectSave.append(self.project)
                 self.project.isLike = true
            }).disposed(by: self.disposeBag)
        }
    }
    
    @IBAction func sharedButtonDidTap(_ sender: Any) {
        AppDelegate.shared?.shareImage(controller: self, link: API.linkImage + "p" + self.project.alias + "-" + self.project.id + ".html", image: #imageLiteral(resourceName: "demo"))
    }
}

extension DetailProjectViewController: ImagePageViewControllerDelegate {
    func imagePageViewController(_ imagePageViewController: ImagePageViewController, didUpdatePageCount count: Int) {
        
    }
    
    func imagePageViewController(_ imagePageViewController: ImagePageViewController, didUpdatePageIndex index: Int) {
        self.pageController.currentPage = index
        indexPage = index
    }
    
}
