//
//  SingUpViewController.swift
//  CallDocter
//
//  Created by Huy Duy on 5/24/17.
//  Copyright © 2017 HuyDuy. All rights reserved.
//

import UIKit
import ACProgressHUD
import UIAlertView_Blocks

class SingUpViewController: BaseTableViewController {

    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var nameLogin: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var newpassWord: UITextField!
    @IBOutlet weak var btnSingUp: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if user != nil {
//            self.btnSingUp.setTitle("Cập nhật thông tin", for: .normal)
//            self.fillData()
//        }
        
    }
    func fillData()
    {
        self.imageUser.layer.cornerRadius = self.imageUser.frame.size.width / 2
        self.imageUser.layer.masksToBounds = true
//        self.nameLogin.text = self.user.login
//        self.fullName.text = self.user.fullName
//        self.imageUser.setImageUrl(url: self.user.website)
//        self.emailTextField.text = self.user.email
        self.password.isHidden = true
        self.newpassWord.isHidden = true
        
    }
    
    @IBAction func buttonSingUp(_ sender: Any) {
//        if user == nil {
//            self.createUser()
//        }
//        else
//        {
//            self.updateUser()
//        }
    }
    
    func updateUser()
    {
        if self.fullName.text == "" {
            self.showAlert("Bạn chưa nhập họ và tên")
            self.fullName.becomeFirstResponder()
            return
        }
        
        if self.emailTextField.text == "" {
            self.showAlert("Bạn chưa nhập Email")
            self.emailTextField.becomeFirstResponder()
            return
        }
        
        if self.nameLogin.text  == "" {
            self.showAlert("Bạn chưa nhập tên đăng nhập")
            self.newpassWord.becomeFirstResponder()
            return
        }
        self.showHUD("")
      
    }
    func createUser()
    {
        if self.fullName.text == "" {
            self.showAlert("Bạn chưa nhập họ và tên")
            self.fullName.becomeFirstResponder()
            return
        }
        
        if self.emailTextField.text == "" {
            self.showAlert("Bạn chưa nhập Email")
            self.emailTextField.becomeFirstResponder()
            return
        }
        
        if self.password.text == "" {
            self.showAlert("Bạn chưa nhập mật khẩu")
            self.password.becomeFirstResponder()
            return
        }
        
        if (self.password.text?.count)! < 8 {
            self.showAlert("Mật khẩu phải lớn hơn 8 ký tự")
            self.password.becomeFirstResponder()
            return
        }
        
        if self.password.text != self.newpassWord.text {
            self.showAlert("Mật khẩu không trùng khớp")
            self.newpassWord.becomeFirstResponder()
            return
        }
        
        if self.nameLogin.text  == "" {
            self.showAlert("Bạn chưa nhập tên đăng nhập")
            self.newpassWord.becomeFirstResponder()
            return
        }
        
        self.showHUD("")
        

    }

}

