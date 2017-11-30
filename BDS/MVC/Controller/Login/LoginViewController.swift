//
//  LoginViewController.swift
//  CallDocter
//
//  Created by DevOminext on 5/22/17.
//  Copyright © 2017 HuyDuy. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import ACProgressHUD

let USERNAME = "username"
let PASSWORD = "password"

class LoginViewController: BaseTableViewController {

    @IBOutlet weak var btnLogin: CustomRoundButton!
    @IBOutlet weak var btnSingUp: CustomRoundButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        let defaults = UserDefaults.standard
        let username = defaults.object(forKey: USERNAME) as? String
        let pass = defaults.object(forKey: PASSWORD) as? String
        if username != nil && username != "" {
            self.showHUD("")
            self.login(username: username!, pass: pass!)
            self.email.text = username
            self.pass.text = pass
        }
       
    }


    @IBAction func btnLoginView(_ sender: Any) {
        AppDelegate.shared?.setHomeRootViewControoler()
//        if self.email.text?.count == 0 {
//            self.showAlert("Bạn chưa nhập tên tài khoản")
//            self.email.becomeFirstResponder()
//            return
//        }
//
//        if self.pass.text?.count == 0 {
//            self.showAlert("Bạn chưa nhập mật khẩu")
//            self.pass.becomeFirstResponder()
//            return
//        }
//        if (self.pass.text?.count)! < 8 {
//            self.showAlert("Mật khẩu phải lớn hơn 8 ký tự")
//            self.pass.becomeFirstResponder()
//            return
//        }
//        self.showHUD("")
//        self.login(username: self.email.text!, pass: self.pass.text!)
    }

    func login(username: String, pass: String) {

        

    }

    @IBAction func buttonSingUp(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        let singUp = storyboard.instantiateViewController(withIdentifier: "ContainerSingUpViewController") as! ContainerSingUpViewController
        self.navigationController?.pushViewController(singUp, animated: true)
    }
    
    
    @IBAction func resetPassButtonDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        let singUp = storyboard.instantiateViewController(withIdentifier: "ContainerSingUpViewController") as! ContainerSingUpViewController
        singUp.isResetPass = true
        self.navigationController?.pushViewController(singUp, animated: true)
        
    }
    
}
