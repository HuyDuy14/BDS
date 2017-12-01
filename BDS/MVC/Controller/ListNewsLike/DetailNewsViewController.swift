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

    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }
    func loadData() {
//        self.showHUD("")

       
//        self.detaiNews.bodyhtml = self.detaiNews.bodyhtml.replacingOccurrences(of: "width=\"600", with: "width=\"\(self.view.frame.size.width - 20)")
//        self.detaiNews.bodyhtml = self.detaiNews.bodyhtml.replacingOccurrences(of: "height=\"450", with: "height=\"350")
//            let htmlString = HTMLHelper.htmlString(from: self.detaiNews.bodyhtml )
//        if self.detaiNews.homeimgfile != "" {
//            self.imageBanner.kf.setImage(with: URL(string: result.url + self.detaiNews.homeimgfile), placeholder: UIImage(named: "icon_ImageSchool"))
//        } else {
//            self.heightImage.constant = 0
//            self.heightView.constant = 100
//        }
//        var time = "0"
//        if (self.detaiNews.edittime != "") {
//            time = self.detaiNews.edittime
//        } else {
//            time = self.detaiNews.addtime
//        }
        let date = Date()
        self.dateUp.text = "Ngày tạo:" + date.formatDateDD
        self.titleNews.text = "Huy Duy"
//        let height = round(self.titleNews.getLabelHeight())
//        let count = round(height / 18)
//        let heightLabel = count * 18
//        self.heightView.constant = self.imageBanner.frame.size.height + 48 + heightLabel
        self.detailWebView.loadHTMLString("lol", baseURL: nil)
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.popToView()
    }
    
}
