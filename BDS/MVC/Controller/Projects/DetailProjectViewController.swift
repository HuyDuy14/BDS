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

    @IBOutlet weak var saveLandButton: UIButton!
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
    
    var project:ProjectsModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillData()
      
    }
    
    func fillData()
    {

        self.nameUserProjects.text = project.investor
        self.imageProjects.setImageProject(urlString: API.linkImage + project.image)
        self.addressProject.text = project.address
        self.titleproject.text = project.title
        self.allAcreage.text = project.land_area + "m2"
        self.monney.text = project.price + "/m2"
        self.date.text = project.date_finish.FromStringToDateToStringProjects()
        self.scaleProject.text = project.summary
        self.webView.loadHTMLString(Util.shared.htmlString(from: project.content), baseURL: nil)
        if self.project.isLike == true
        {
            self.saveLandButton.tintColor = UIColor.red
        }
        else
        {
            self.saveLandButton.tintColor = UIColor.lightGray
        }
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
                self.saveLandButton.tintColor = UIColor.lightGray
            }).disposed(by: self.disposeBag)
        }
        else
        {
            APIClient.shared.saveNews(id: self.project.id, type: 2).asObservable().bind(onNext: { result in
                self.hideHUD()
                Util.shared.listProjectSave.append(self.project)
                self.saveLandButton.tintColor = UIColor.red
                 self.project.isLike = true
            }).disposed(by: self.disposeBag)
        }
    }
    
    @IBAction func sharedButtonDidTap(_ sender: Any) {
        AppDelegate.shared?.shareImage(controller: self, link: "", image: #imageLiteral(resourceName: "demo"))
    }
}
