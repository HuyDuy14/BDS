//
//  InforAppViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/9/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class InforAppViewController: BaseViewController,UIWebViewDelegate {

    @IBOutlet weak var textInforLabel: UILabel!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var heightView: NSLayoutConstraint!
    
    @IBOutlet weak var dkLabel: UILabel!
    @IBOutlet weak var imageInfor: UIImageView!
    var isShowMenu:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isShowMenu == true
        {
//            if let url = URL(string: "https://chobatdongsan.com.vn/gioi-thieu-st36") {
//                let request = URLRequest(url: url)
//                webView.loadRequest(request)
//                webView.translatesAutoresizingMaskIntoConstraints = false
//                webView.isUserInteractionEnabled = true
//                webView.delegate = self
//                self.webView.addSubview(self.progress)
//                self.progress.startAnimating()
//                self.progress.hidesWhenStopped = true
//            }
            self.titleView.text = "Thông tin về chúng tôi"
            self.dkLabel.isHidden = true
            let height =  self.textInforLabel.getLabelHeight()
            self.heightView.constant = height + 340
        }
        else
        {
            self.textInforLabel.isHidden = true
            self.titleView.text = "Điều khoản"
            let height =  self.dkLabel.getLabelHeight()
            self.heightView.constant = height + 240
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
