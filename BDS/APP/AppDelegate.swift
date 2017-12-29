//
//  AppDelegate.swift
//  BDS
//
//  Created by Duy Huy on 11/29/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GoogleSignIn
import FBSDKCoreKit
import RxCocoa
import OneSignal
import RxSwift
import SwiftMessages
import IQKeyboardManagerSwift

let API_KEY_GOOGLE = "AIzaSyBD1kiOal8TizmhXeYSvG1sa9FH9okzI44"
var appId: String = "95bd2b1a-6eec-494d-821c-40830e86740e"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {

    var window: UIWindow?
    static var shared = (UIApplication.shared.delegate as? AppDelegate)
    let disposeBag = DisposeBag()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Done"
        GMSServices.provideAPIKey(API_KEY_GOOGLE)
        GMSPlacesClient.provideAPIKey(API_KEY_GOOGLE)
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        self.settingNotiOnsignal(launchOptions: launchOptions)
        self.loadDataCity()
        return true
    }

    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any])
        -> Bool {
            
            let googleDidHandle = GIDSignIn.sharedInstance().handle(
                url,
                sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                annotation: options[UIApplicationOpenURLOptionsKey.annotation])
            let facebookDidHandle = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, options: options)
            return googleDidHandle || facebookDidHandle
            
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        let googleDidHandle = GIDSignIn.sharedInstance().handle(url as URL!,
                                                                sourceApplication: sourceApplication,
                                                                annotation: annotation)
        let facebookDidHandle = FBSDKApplicationDelegate.sharedInstance().application(
            application,
            open: url as URL!,
            sourceApplication: sourceApplication,
            annotation: annotation)
        
        return  googleDidHandle || facebookDidHandle
    }
    
    
    func settingNotiOnsignal(launchOptions:[UIApplicationLaunchOptionsKey: Any]?)
    {
        let notificationReceivedBlock: OSHandleNotificationReceivedBlock = { notification in
            
            print("Received Notification: \(notification!.payload.notificationID)")
        }
        
        let notificationOpenedBlock: OSHandleNotificationActionBlock = { result in
            
//            let payload: OSNotificationPayload = result!.notification.payload
            
        }
        
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: true,
                                     kOSSettingsKeyInAppLaunchURL: true]
        
        OneSignal.initWithLaunchOptions(launchOptions,
                                        appId: appId,
                                        handleNotificationReceived: notificationReceivedBlock,
                                        handleNotificationAction: notificationOpenedBlock,
                                        settings: onesignalInitSettings)
        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;
 
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })
        
        
    }
   
    
    func registerForRemoteNotification() {
        if #available(iOS 10.0, *) {
            let center  = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
                if error == nil{
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                    
                }
            }
        }
        else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
extension AppDelegate
{
    
    func setHomeRootViewControoler() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "NaviHomeViewController")
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }
    
    func setLoginRootViewControoler() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "NaviLoginViewController")
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }
}

extension AppDelegate
{
    func loadDataCity()
    {
        Util.shared.listCity = []
        APIClient.shared.getCity().asObservable().bind(onNext: { result in
            for data in result.dataArray
            {
                if let dic = data as? [String:Any]
                {
                    let city = ModelCity(JSON: dic)
                    Util.shared.listCity.append(city!)
                }
            }
            
        }).disposed(by: self.disposeBag)
    }
    
    func showMessagePopUp(title:String,message:String) {
        let view = MessageView.viewFromNib(layout: .messageView)
        view.configureTheme(.success)
        view.configureDropShadow()
        view.button?.setTitle(nil, for: .normal)
        view.button?.backgroundColor = UIColor.clear
        view.button?.tintColor = UIColor.green.withAlphaComponent(0.7)
        view.configureContent(title: title, body: message, iconText: "")
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        view.backgroundView.backgroundColor = UIColor.red
        SwiftMessages.show(view: view)
    }
    
    func showMessageSuccessPopUp() {
        let view = MessageView.viewFromNib(layout: .messageView)
        view.configureTheme(.success)
        view.configureDropShadow()
        view.button?.setTitle(nil, for: .normal)
        view.button?.backgroundColor = UIColor.clear
        view.button?.tintColor = UIColor.green.withAlphaComponent(0.7)
        view.configureContent(title: "Đăng nhập thành công", body: "Bây giờ bạn có thể tìm kiếm bất động sản bất kỳ", iconText: "")
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        view.backgroundView.backgroundColor = UIColor.init(netHex: 0x12B053)
        SwiftMessages.show(view: view)
    }
    func handleTap() {
        SwiftMessages.hide()
    }
    
    func shareImage(controller:UIViewController,link:String,image:UIImage){
        let text = link
        let objectsToShare = [text] as [Any]
        let activityViewController = UIActivityViewController(activityItems:objectsToShare, applicationActivities: nil)
        let excludeActivities = [
            UIActivityType.message,
            UIActivityType.mail,
            UIActivityType.print,
            UIActivityType.copyToPasteboard,
            UIActivityType.assignToContact,
            UIActivityType.addToReadingList,
            UIActivityType.saveToCameraRoll,
            UIActivityType.postToFlickr,
            UIActivityType.postToTencentWeibo,
            UIActivityType.airDrop,
            UIActivityType.postToTwitter,
            UIActivityType.openInIBooks]
        activityViewController.excludedActivityTypes = excludeActivities;
        controller.present(activityViewController, animated: true, completion: nil)
    }
    

}

