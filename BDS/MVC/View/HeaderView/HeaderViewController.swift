//
//  HeaderViewController.swift
//
//
//  Created by HuyDuy on 5/22/17.
//  Copyright © 2017 HuyDuy. All rights reserved.
//

import UIKit

@objc protocol HeaderViewControllerDelegate {
    @objc optional func basicHeaderViewDidTouchButtonClose()
    @objc optional func basicHeaderViewDidTouchButtonLeft()
}

class HeaderViewController: UIView {

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnReporting: UIButton!
    @IBOutlet weak var infor: UILabel!
    
    weak var delegate: HeaderViewControllerDelegate?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let views = Bundle.main.loadNibNamed("HeaderViewController", owner: self, options: nil)
        let mainView = views?[0] as! UIView
        self.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: mainView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: mainView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: mainView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: mainView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
    }

    func setTitleView(title:String, infor: String){
        self.titleView.text = title
        self.infor.text = infor
    }

    @IBAction func actionReporting(_ sender: Any) {
        self.delegate?.basicHeaderViewDidTouchButtonLeft!()
    }
    @IBAction func btnBackViewController(_ sender: Any) {
//        SaveDataApp.idGroup = ""
        self.delegate?.basicHeaderViewDidTouchButtonClose!()
    }
}
