//
//  SingUpViewController.swift
//  CallDocter
//
//  Created by Huy Duy on 5/24/17.
//  Copyright © 2017 HuyDuy. All rights reserved.
//

import UIKit
import ACProgressHUD_Swift
import UIAlertView_Blocks
import RxSwift
import RxCocoa

class SingUpViewController: BaseTableViewController {

   
    @IBOutlet weak var btnSingUp: UIButton!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonSingUp(_ sender: Any) {
        self.createUser()
    }
    
    func createUser()
    {
        if self.username.text?.count == 0 {
            self.showAlert("Bạn chưa nhập họ và tên")
            self.username.becomeFirstResponder()
            return
        }
        
        if self.email.text?.count == 0 {
            self.showAlert("Bạn chưa nhập Email")
            self.email.becomeFirstResponder()
            return
        }
        
        if self.pass.text?.count == 0 {
            self.showAlert("Bạn chưa nhập mật khẩu")
            self.pass.becomeFirstResponder()
            return
        }
        
        if !Util.shared.isValidEmail(email: self.email.text!)
        {
            self.showAlert("Nhập sai định dạng email")
            self.email.becomeFirstResponder()
            return
        }
        self.showHUD("")
        APIClient.shared.registerUser(email: self.email.text!, username: self.username.text!, password: self.pass.text!).asObservable().bind(onNext: {result in
            self.showAlert("Đăng ký thành công")
            self.hideHUD()
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: self.disposeBag)
    }
    
}

