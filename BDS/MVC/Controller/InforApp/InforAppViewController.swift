//
//  InforAppViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/9/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class InforAppViewController: BaseViewController,UIWebViewDelegate {

    @IBOutlet weak var progress: UIActivityIndicatorView!
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: "https://chobatdongsan.com.vn/gioi-thieu-st36") {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
            webView.translatesAutoresizingMaskIntoConstraints = false
            webView.isUserInteractionEnabled = true
            webView.delegate = self
            self.webView.addSubview(self.progress)
            self.progress.startAnimating()
            self.progress.hidesWhenStopped = true
        }
    }

    @IBAction func backButtonDidTap(_ sender: Any) {
        self.popToView()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
         progress.stopAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
         progress.stopAnimating()
    }
 
}
