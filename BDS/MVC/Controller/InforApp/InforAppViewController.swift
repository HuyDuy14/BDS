//
//  InforAppViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/9/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class InforAppViewController: BaseViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: "https://chobatdongsan.com.vn/gioi-thieu-st36") {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }

    @IBAction func backButtonDidTap(_ sender: Any) {
        self.popToView()
    }
}
