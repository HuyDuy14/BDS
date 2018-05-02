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
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit

class SingUpViewController: BaseTableViewController {

    @IBOutlet weak var btnLoginGoogle: UIButton!
    @IBOutlet weak var btnLoginFb: UIButton!
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
            self.showAlert("Đăng ký thành công. Bạn vui lòng kiểm tra email hệ thống gửi về để kích hoạt tài khoản")
            self.hideHUD()
            self.popToView()
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: self.disposeBag)
    }
    
    @IBAction func loginFBButtonDidTap(_ sender: Any) {
        self.btnLoginFb.isEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.btnLoginFb.isEnabled = true
        }
        
        // still have token, let check
        if ((FBSDKAccessToken.current()) != nil) {
            
            print(FBSDKAccessToken.current().tokenString)
             self.loginWidth_fb( fbid: FBSDKAccessToken.current().userID, name: "fix")
            //            print(FBSDKAccessToken.current().)
            
        } else {
            getFBToken()
            
        }
    }
    
    @IBAction func loginGoogleButtonDidTap(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
        
        self.btnLoginGoogle.isEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.btnLoginGoogle.isEnabled = true
        }
    }
  
}

extension SingUpViewController
{
    // MARK : - Login facebook
    func getFBToken() {
        
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: ["public_profile", "user_location", "user_birthday"], from: self) { (result: FBSDKLoginManagerLoginResult?, error: Error?) in
            
            if (error != nil) {
                
                print(error ?? "unknown")
                
                FBSDKLoginManager().logOut()
                FBSDKAccessToken.setCurrent(nil)
                
            } else if (result?.isCancelled)! {
                
                print("Cancel")
            } else {
                self.loginWidth_fb( fbid: FBSDKAccessToken.current().userID, name: "fix")
            }
        }
        
    }
    
    func getFBInfo(){
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email, timezone, gender, location, interested_in, birthday"])
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(String(describing: error))")
            }
            else
            {
                print("fetched user: \(String(describing: result))")
                if let resultDic = result as? Dictionary<String, AnyObject> {
                    
                    print(resultDic)
                }
            }
        })
    }
    
    func loginWidth_fb( fbid: String,name:String) {
        self.showHUD("Login")
        APIClient.shared.loginFB( fbid: fbid, name: name).asObservable().bind(onNext: { result in
            UserDefaults.standard.set(fbid, forKey: FBID)
            UserDefaults.standard.set(name, forKey: FBNAME)
            UserDefaults.standard.set("", forKey: USERNAME)
            UserDefaults.standard.set("", forKey: PASSWORD)
            UserDefaults.standard.set("", forKey: GGID)
            Util.shared.currentUser = UserModel(JSON: result.data!)!
            if SaveCurrentVC.shared.homeController != nil
            {
                AppDelegate.shared?.setHomeRootViewControoler()
            }
            else
            {
                SaveCurrentVC.shared.containerLogin?.dismiss(animated: true, completion: nil)
            }
            AppDelegate.shared?.showMessageSuccessPopUp()
            self.hideHUD()
        }).disposed(by: self.disposeBag)
    }
    
    
}

extension SingUpViewController:GIDSignInDelegate,GIDSignInUIDelegate
{
    // MARK : -Login goole
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        self.loginWidth_GG(email: user.profile.email, ggID:  user.userID, name:  user.profile.name)
    }
    
    func loginWidth_GG(email:String,ggID:String,name:String)
    {
        self.showHUD("Login")
        APIClient.shared.loginGG(email: email, fbid: ggID, name: name).asObservable().bind(onNext: { result in
            UserDefaults.standard.set("", forKey: FBID)
            UserDefaults.standard.set("", forKey: FBNAME)
            UserDefaults.standard.set("", forKey: USERNAME)
            UserDefaults.standard.set("", forKey: PASSWORD)
            UserDefaults.standard.set(ggID, forKey: GGID)
            UserDefaults.standard.set(email, forKey: GGEMAIL)
            UserDefaults.standard.set(name, forKey: GGNAME)
            Util.shared.currentUser = UserModel(JSON: result.data!)!
            if SaveCurrentVC.shared.homeController != nil
            {
                AppDelegate.shared?.setHomeRootViewControoler()
            }
            else
            {
                SaveCurrentVC.shared.containerLogin?.dismiss(animated: true, completion: nil)
            }
            AppDelegate.shared?.showMessageSuccessPopUp()
            self.hideHUD()
        }).disposed(by: self.disposeBag)
    }
}


