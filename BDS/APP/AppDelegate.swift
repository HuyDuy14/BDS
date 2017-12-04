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
import RxSwift

let API_KEY_GOOGLE = "AIzaSyDeHiOsROpzfS0K2ys91RoZhym8tGSbtYE"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var shared = (UIApplication.shared.delegate as? AppDelegate)
    let disposeBag = DisposeBag()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey(API_KEY_GOOGLE)
        GMSPlacesClient.provideAPIKey(API_KEY_GOOGLE)
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
}

