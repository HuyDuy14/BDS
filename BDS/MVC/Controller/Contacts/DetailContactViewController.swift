//
//  DetailContactViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/6/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class DetailContactViewController: BaseViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    
    var contact:BrokerModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleView.text = self.contact.title
        self.email.text = self.contact.email
        self.address.text =  self.contact.address
        self.imageProfile.setImageProject(urlString: API.linkImage + self.contact.image)
        self.phone.text = self.contact.phone
        self.webView.loadHTMLString(Util.shared.htmlString(from: contact.content), baseURL: nil)
    }

    @IBAction func backButtonDidTap(_ sender: Any) {
        self.popToView()
    }
}
