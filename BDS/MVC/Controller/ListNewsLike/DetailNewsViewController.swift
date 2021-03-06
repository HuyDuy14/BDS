//
//  DetailNewsViewController.swift
//  SchoolManagement
//
//  Created by Duy Huy on 9/20/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import RxSwift

class DetailNewsViewController: BaseViewController,UIWebViewDelegate {

//    @IBOutlet weak var heightImage: NSLayoutConstraint!
//    @IBOutlet weak var titleNews: UILabel!
//    @IBOutlet weak var heightView: NSLayoutConstraint!
//    @IBOutlet weak var dateUp: UILabel!
//    @IBOutlet weak var imageBanner: UIImageView!
    @IBOutlet weak var detailWebView: UIWebView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    @IBOutlet weak var newsSave: UIImageView!
    var news: NewsModel!
    let disposeBag = DisposeBag()
    var isNews: Bool = true
    var isNewsBDS:Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        if isNews == true
            {
            self.loadData()
            self.getDataDetailNews()
        }
            else
        {
            self.getDataServer()
        }
    }

    func getDataServer()
    {
        self.newsSave.isHidden = true
        self.btnSave.isHidden = true
        self.showHUD("")
        APIClient.shared.getAsvise(id:self.news.id).asObservable().bind(onNext: { result in

            self.news = NewsModel(JSON: result.data!)
            for newsSave in Util.shared.listNewsSave
            {
                if newsSave.id == self.news.id {
                    self.news.isLike = true
                }
            }
//            self.news.content = self.news.content.replacingOccurrences(of: "width: 500px", with: "width: \(self.detailWebView.frame.size.width - 20)px")
//            self.news.content = self.news.content.replacingOccurrences(of: "width: 600px", with: "width: \(self.detailWebView.frame.size.width - 20)px")
//            self.news.content = self.news.content.replacingOccurrences(of: "500px", with: "\(self.detailWebView.frame.size.width - 20)px")
//            self.news.content = self.news.content.replacingOccurrences(of: "600px", with: "\(self.detailWebView.frame.size.width - 20)px")
//              self.news.content = self.news.content.replacingOccurrences(of: "615px", with: "\(self.detailWebView.frame.size.width - 20)px")
    
            self.loadData()

            self.hideHUD()
        }).disposed(by: self.disposeBag)
    }

    func getDataDetailNews()
    {
        self.newsSave.isHidden = true
        self.btnSave.isHidden = true
        self.showHUD("")
        APIClient.shared.getDetailNews(id: self.news.id,isNewsBDS: self.isNewsBDS).asObservable().bind(onNext: { result in

            self.news = NewsModel(JSON: result.data!)

//            self.news.content = self.news.content.replacingOccurrences(of: "width: 500px", with: "width: \(self.detailWebView.frame.size.width - 20)px")
//            self.news.content = self.news.content.replacingOccurrences(of: "width: 600px", with: "width: \(self.detailWebView.frame.size.width - 20)px")
//            self.news.content = self.news.content.replacingOccurrences(of: "500px", with: "\(self.detailWebView.frame.size.width - 20)px")
//            self.news.content = self.news.content.replacingOccurrences(of: "600px", with: "\(self.detailWebView.frame.size.width - 20)px")
            for newsSave in Util.shared.listNewsSave
            {
                if newsSave.id == self.news.id {
                    self.news.isLike = true
                }
            }
            self.loadData()

            self.hideHUD()
        }).disposed(by: self.disposeBag)
    }

    func loadData() {

//        self.imageBanner.setImageUrlNews(url: API.linkImage + news.image)
//        self.dateUp.text = "Ngày tạo:" + news.created_time.FromStringToDateToStringNews()
//        self.titleNews.text = news.title
//        let height = round(self.titleNews.getLabelHeight())
//        let count = round(height / 18)
//        let heightLabel = count * 18
//        self.heightView.constant = self.imageBanner.frame.size.height + 48 + heightLabel
        self.news.content = Util.shared.webViewChangeFont(htmlString: news.content)
        self.news.content = self.news.content.replacingOccurrences(of: "linkImageView", with: API.linkImage + news.image)
        self.news.content = self.news.content.replacingOccurrences(of: "00001px", with: "\(self.view.frame.width - 20)px")
        let dateString = news.created_time.FromStringToDateToStringNews()
        self.news.content = self.news.content.replacingOccurrences(of: "datecreate...", with:  dateString )
//        self.news.content = self.news.content.replacingOccurrences(of: "dd", with:  news.created_time.FromStringToDateToDD() )
//        self.news.content = self.news.content.replacingOccurrences(of: "MM", with:  news.created_time.FromStringToDateToMM() )
//        self.news.content = self.news.content.replacingOccurrences(of: "YY", with:  news.created_time.FromStringToDateToYYYY() )
        self.news.content = self.news.content.replacingOccurrences(of: "title...", with:  news.title)
        self.detailWebView.delegate = self
        self.detailWebView.loadHTMLString(self.news.content, baseURL: nil)
        self.progress.startAnimating()
        self.progress.hidesWhenStopped = true
        if self.news.isLike == true {
            self.newsSave.tintColor = UIColor.red
        }
            else
        {
            self.newsSave.tintColor = UIColor.lightGray
        }
    }

    @IBAction func backButtonDidTap(_ sender: Any) {
        self.popToView()
    }

    @IBAction func saveNewsButtonDidTap(_ sender: Any) {
        self.showHUD("")
        if news.isLike == false {
            APIClient.shared.saveNews(id: news.id, type: 1).asObservable().bind(onNext: { result in
                self.hideHUD()
                for newsSave in Util.shared.listNewsSave
                {
                    if newsSave.id == self.news.id {
                        Util.shared.listNewsSave.append(newsSave)
                    }
                }
                self.newsSave.tintColor = UIColor.red
                self.news.isLike = true
            }).disposed(by: self.disposeBag)
        }
        else
        {
            APIClient.shared.cancelNews(id: news.id, type: 1).asObservable().bind(onNext: { result in
                self.hideHUD()
                for i in 0..<(Util.shared.listNewsSave.count - 1)
                {
                    if Util.shared.listNewsSave[i].id == self.news.id {
                        Util.shared.listNewsSave.remove(at: i)
                    }
                }
                self.news.isLike = false
                self.newsSave.tintColor = UIColor.lightGray
            }).disposed(by: self.disposeBag)
        }
    }
    @IBAction func sharedButtonDidTap(_ sender: Any) {
        if isNews == true {
            AppDelegate.shared?.shareImage(controller: self, link: API.linkImage + "ns" + self.news.category_name + "/" + news.alias + "-p" + self.news.id + ".html", image: #imageLiteral(resourceName: "demo"))
        }
        else
        {
            AppDelegate.shared?.shareImage(controller: self, link: API.linkImage + "tv" + self.news.category_name + "/" + news.alias + "-p" + self.news.id + ".html", image: #imageLiteral(resourceName: "demo"))
        }
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        progress.stopAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        progress.stopAnimating()
    }

}

