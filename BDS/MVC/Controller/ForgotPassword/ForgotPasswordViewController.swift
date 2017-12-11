//
//  ForgotPasswordViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/11/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ForgotPasswordViewController: BaseTableViewController {

    @IBOutlet weak var email: UITextField!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func sendButtoDidTap(_ sender: Any) {
        if self.email.text?.count == 0
        {
            self.showAlert("Bạn chưa nhập email")
            self.email.becomeFirstResponder()
            return
        }
        self.showHUD("")
        APIClient.shared.forgotPass(email: self.email.text!).asObservable().bind(onNext: {result in
            self.hideHUD()
            self.showAlert("Bạn vào email đã đăng ký nhận lại mật khẩu")
        }).disposed(by: disposeBag)
    }
    
}
