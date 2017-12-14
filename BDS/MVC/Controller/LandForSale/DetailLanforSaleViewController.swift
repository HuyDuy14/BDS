//
//  DetailLanforSaleViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/7/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class DetailLanforSaleViewController: BaseViewController {

    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var saveLandButton: UIButton!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var nameContact: UILabel!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var dateEnd: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var dateBegin: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var idLand: UILabel!
    @IBOutlet weak var address: UILabel!
    
    let disposeBag = DisposeBag()
    var landForSale:LandSaleModel!
    //Page Image
    weak var currenviewController: UIViewController?
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageController: UIPageControl!
    var imagePageViewController: ImagePageViewController?
    var timer:Timer!
    var indexPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.fillData()
        self.loadDataServer()
    }
    
    func updateStart() {
        indexPage += 1
        if indexPage >= self.landForSale.list_image.count
        {
            indexPage = 0
        }
        self.imagePageViewController?.scrollToViewController(index: indexPage)
    }
    
    func loadDataServer()
    {
        self.showHUD("")
        APIClient.shared.getDetailSale(id: self.landForSale.id).asObservable().bind(onNext: {result in
            self.landForSale = LandSaleModel(JSON: result.data!)
            let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
            let showView = storyboard.instantiateViewController(withIdentifier: "ImagePageViewController") as? ImagePageViewController
            showView?.imageDelegate = self
            self.imagePageViewController = showView
            if self.landForSale.list_image.count > 0
            {
                self.imageDetail.isHidden = true
            }
            self.timer =  Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.updateStart), userInfo: nil, repeats: true)
            self.pageController.numberOfPages = self.landForSale.list_image.count
            showView?.listImageURL = self.landForSale.list_image
            self.showController(controllerName: "ImagePageViewController", controller: showView)
            self.hideHUD()
        }).disposed(by: self.disposeBag)
    }
    
    func fillData()
    {
        self.imageDetail.setImageUrlNews(url: API.linkImage + self.landForSale.image)
        self.nameContact.text = self.landForSale.poster_name
        self.phone.text = self.landForSale.poster_phone
        self.area.text = self.landForSale.land_area + "m2"
        self.price.text = self.landForSale.land_price + " tỷ/m2"
        self.address.text = self.landForSale.district_name + " , " + self.landForSale.city_name
        self.dateBegin.text = self.landForSale.land_date_start.FromStringToDateToStringProjects()
        self.dateEnd.text = self.landForSale.land_date_finish.FromStringToDateToStringProjects()
        self.type.text = self.landForSale.category_name
        self.idLand.text = self.landForSale.code
        self.landForSale.content = self.landForSale.content.replacingOccurrences(of: "width: 500px", with: "width: \(self.webView.frame.size.width - 20 )px")
        self.landForSale.content = self.landForSale.content.replacingOccurrences(of:"width: 600px", with: "width: \(self.webView.frame.size.width - 20)px")
        self.landForSale.content = self.landForSale.content.replacingOccurrences(of: "500px", with: "\(self.webView.frame.size.width - 20)px")
        self.landForSale.content = self.landForSale.content.replacingOccurrences(of: "600px", with: "\(self.webView.frame.size.width - 20)px")
        
         self.webView.loadHTMLString(Util.shared.htmlString(from: self.landForSale.content), baseURL: nil)
        if self.landForSale.isLike == true
        {
            self.saveLandButton.tintColor = UIColor.red
        }
        else
        {
            self.saveLandButton.tintColor = UIColor.lightGray
        }
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

    
    @IBAction func sharedButtonDidTap(_ sender: Any) {
        AppDelegate.shared?.shareImage(controller: self, link: API.linkImage + "d" + self.landForSale.alias + "-" + self.landForSale.id + ".html", image: self.imageDetail.image!)
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.popToView()
    }
    
    @IBAction func mapButtonDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Projects", bundle: nil)
        let showDetail = storyboard.instantiateViewController(withIdentifier: "DetailMapsViewController") as? DetailMapsViewController
        showDetail?.landForSale = self.landForSale
        self.pushViewController(viewController: showDetail)
    }
    
    @IBAction func saveLandButtonDidTap(_ sender: Any) {
        self.showHUD("")
        if self.landForSale.isLike == true
        {
            APIClient.shared.cancelNews(id: self.landForSale.id, type: 3).asObservable().bind(onNext: { result in
                self.hideHUD()
                for i in 0..<(Util.shared.listBDS.count - 1)
                    {
                    if Util.shared.listBDS[i].id == self.landForSale.id
                    {
                        Util.shared.listBDS.remove(at: i)
                    }
                }
                self.landForSale.isLike = false
                self.saveLandButton.tintColor = UIColor.lightGray
            }).disposed(by: self.disposeBag)
        }
        else
        {
            APIClient.shared.saveNews(id: self.landForSale.id, type: 3).asObservable().bind(onNext: { result in
                self.hideHUD()
                Util.shared.listBDS.append(self.landForSale)
                 self.landForSale.isLike = true
                self.saveLandButton.tintColor = UIColor.red
            }).disposed(by: self.disposeBag)
        }
    }
}

extension DetailLanforSaleViewController: ImagePageViewControllerDelegate {
    func imagePageViewController(_ imagePageViewController: ImagePageViewController, didUpdatePageCount count: Int) {
        
    }
    
    func imagePageViewController(_ imagePageViewController: ImagePageViewController, didUpdatePageIndex index: Int) {
        self.pageController.currentPage = index
        indexPage = index
    }

}
