//
//  DetailNewsViewController.swift
//  SchoolManagement
//
//  Created by Duy Huy on 9/20/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import RxSwift

class DetailNewsViewController: BaseViewController {

    @IBOutlet weak var heightImage: NSLayoutConstraint!
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var heightView: NSLayoutConstraint!
    @IBOutlet weak var dateUp: UILabel!
    @IBOutlet weak var imageBanner: UIImageView!
    @IBOutlet weak var detailWebView: UIWebView!
    
    var news:NewsModel!
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }
    
    func loadData() {
        self.imageBanner.setImageUrlNews(url: API.linkImage + news.image)
        self.dateUp.text = "Ngày tạo:" + news.created_time.FromStringToDateToStringNews()
        self.titleNews.text = news.title
        let height = round(self.titleNews.getLabelHeight())
        let count = round(height / 18)
        let heightLabel = count * 18
        self.heightView.constant = self.imageBanner.frame.size.height + 48 + heightLabel
        self.detailWebView.loadHTMLString(Util.shared.webViewChangeFont(htmlString: news.content), baseURL: nil)
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.popToView()
    }
    
}
