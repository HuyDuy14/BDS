//
//  DetailContactViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/6/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import RxSwift

class DetailContactViewController: BaseViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    
    var contact:BrokerModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        self.getDataDetailContact()
    }

    @IBAction func backButtonDidTap(_ sender: Any) {
        self.popToView()
    }
    
    func loadData()
    {
        self.titleView.text = self.contact.title
        self.email.text = self.contact.email
        self.address.text =  self.contact.address
        self.imageProfile.setImageProject(urlString: API.linkImage + self.contact.image)
        self.phone.text = self.contact.phone
        self.webView.loadHTMLString(Util.shared.htmlString(from: contact.content), baseURL: nil)
    }
    
    func getDataDetailContact()
    {
        
        self.showHUD("")
        APIClient.shared.getDetailBorker(id: self.contact.id).asObservable().bind(onNext: {result in
            let contact  = BrokerModel(JSON: result.data!)
            if contact?.id.count != 0
            {
                self.contact = contact
            }
            self.contact.content = self.contact.content.replacingOccurrences(of: "width: 500px", with: "width: \(self.webView.frame.size.width - 20 )px")
            self.contact.content = self.contact.content.replacingOccurrences(of:"width: 600px", with: "width: \(self.webView.frame.size.width - 20)px")
            self.contact.content = self.contact.content.replacingOccurrences(of: "500px", with: "\(self.webView.frame.size.width - 20)px")
            self.contact.content = self.contact.content.replacingOccurrences(of: "600px", with: "\(self.webView.frame.size.width - 20)px")
            self.loadData()
            self.hideHUD()
        }).disposed(by: self.disposeBag)
    }
    
}
