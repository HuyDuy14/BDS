//
//  DetailProjectViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/5/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

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
    
    var project:ProjectsModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillData()
      
    }
    
    func fillData()
    {
//        if project.isLike == true
//        {
//
//        }
        self.nameUserProjects.text = project.investor
        self.imageProjects.setImageProject(urlString: API.linkImage + project.image)
        self.addressProject.text = project.address
        self.titleproject.text = project.title
        self.allAcreage.text = project.land_area + "m2"
        self.monney.text = project.price + "/m2"
        self.date.text = project.date_finish.FromStringToDateToStringProjects()
        self.scaleProject.text = project.summary
        self.webView.loadHTMLString(Util.shared.htmlString(from: project.content), baseURL: nil)
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
    }
}
