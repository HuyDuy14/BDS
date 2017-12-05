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
        self.allAcreage.text = project.investor
        self.monney.text = project.price
        self.date.text = project.date_finish.FromStringToDateToStringProjects()
        self.webView.loadHTMLString(Util.shared.htmlString(from: project.content), baseURL: nil)
    }
    

    // MARK: - UIAction
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.popToView()
    }
    
    @IBAction func showMapsButtonDidTap(_ sender: Any) {
    }
    
    @IBAction func saveButtonDidTap(_ sender: Any) {
    }
}
