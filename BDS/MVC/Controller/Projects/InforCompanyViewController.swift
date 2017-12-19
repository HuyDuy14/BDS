//
//  InforCompanyViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/19/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class InforCompanyViewController: BaseViewController,UIWebViewDelegate {

    @IBOutlet weak var progress: UIActivityIndicatorView!
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.loadHTMLString(Util.shared.htmlString(from: Util.shared.projectsDetail.info_investor), baseURL: nil)
        self.webView.delegate = self
        self.progress.startAnimating()
        self.progress.hidesWhenStopped = true
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        progress.stopAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        progress.stopAnimating()
    }
    

}
