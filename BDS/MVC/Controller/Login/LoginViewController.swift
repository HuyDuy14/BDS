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
import ACProgressHUD_Swift
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit

let USERNAME = "username"
let PASSWORD = "password"
let FBID = "FBID"
let FBNAME = "FBNAME"
let GGID = "GGID"
let GGNAME = "GGNAME"
let GGEMAIL = "GGEMAIL"
let clientID: String = "51046093520-24c1on1oarc186d6n0n2lnvfq5n158b2.apps.googleusercontent.com"

class LoginViewController: BaseTableViewController {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!
    
    @IBOutlet weak var btnLoginGoogle: UIButton!
    @IBOutlet weak var btnLoginFb: UIButton!
    
    var ggUser: GIDGoogleUser? = nil
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        GIDSignIn.sharedInstance().clientID = clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        self.navigationController?.isNavigationBarHidden = true
        let defaults = UserDefaults.standard
        let username = defaults.object(forKey: USERNAME) as? String
        let pass = defaults.object(forKey: PASSWORD) as? String
        let fbID = defaults.object(forKey: FBID) as? String
        let ggID =  defaults.object(forKey: GGID) as? String
        if username?.count != 0  && username?.count != nil{
            self.login(username: username!, pass: pass!)
            self.email.text = username
            self.pass.text = pass
        }
        if fbID?.count != 0 && fbID?.count  != nil
        {
            let name = defaults.object(forKey: FBNAME) as? String
            self.loginWidth_fb(fbid: fbID!, name: name!)
        }
        
        if ggID?.count != 0 && ggID?.count != nil
        {
            let name = defaults.object(forKey: GGNAME) as? String ?? ""
            let email = defaults.object(forKey: GGEMAIL) as? String ?? ""
            self.loginWidth_GG(email: email, ggID: ggID!, name: name)
        }
        
    }


    @IBAction func btnLoginView(_ sender: Any) {
        if self.email.text?.count == 0
        {
            self.showAlert("Bạn chưa nhập tên đăng nhập hoặc email")
            self.email.becomeFirstResponder()
            return
        }
        if self.pass.text?.count == 0
        {
            self.showAlert("Bạn chưa nhập mật khẩu")
            self.pass.becomeFirstResponder()
            return
        }
        self.login(username: self.email.text!, pass: self.pass.text!)
    }

    func login(username: String, pass: String) {
        self.showHUD("Login")
        APIClient.shared.login(username: username, password: pass).asObservable().bind(onNext: { result in
            
            UserDefaults.standard.set("", forKey: FBID)
            UserDefaults.standard.set("", forKey: FBNAME)
            UserDefaults.standard.set(username, forKey: USERNAME)
            UserDefaults.standard.set(pass, forKey: PASSWORD)
            UserDefaults.standard.set("", forKey: GGID)
            UserDefaults.standard.set("", forKey: GGEMAIL)
            UserDefaults.standard.set("", forKey: GGNAME)
            Util.shared.currentUser = UserModel(JSON: result.data!)!
            AppDelegate.shared?.setHomeRootViewControoler()
            self.hideHUD()
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
    
    @IBAction func resetPassButtonDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let forgotVC = storyboard.instantiateViewController(withIdentifier: "ContainerForgotPassViewController") as! ContainerForgotPassViewController
        self.present(forgotVC, animated: true, completion: nil)
        
    }
}

extension LoginViewController
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
             AppDelegate.shared?.setHomeRootViewControoler()
            self.hideHUD()
        }).disposed(by: self.disposeBag)
    }


}

extension LoginViewController:GIDSignInDelegate,GIDSignInUIDelegate
{
    // MARK : -Login goole
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
         ggUser = user
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
            AppDelegate.shared?.setHomeRootViewControoler()
            self.hideHUD()
        }).disposed(by: self.disposeBag)
    }
}
