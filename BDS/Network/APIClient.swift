//
//  APIClient.swift
//  Tracking
//
//  Created by Duy Huy on 10/13/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import ACProgressHUD

class APIClient: NSObject {
    static let shared = APIClient()
    let headers = [
        "Content-Type": "application/x-www-form-urlencoded"
    ]
    //MARK: - Base function. Not change this section
    //======================================================
    func request(path: String, method: HTTPMethod, params: Parameters!) -> Observable<Result> {
        // Set timeout for 3'
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 180
        
        let url = URL(string: "\(API.serverURL)\(path)")
        return Observable.create {
            observer in
            let request = Alamofire.request(url!, method: method, parameters: params, encoding: URLEncoding.httpBody, headers: self.headers).responseJSON {
                response in
                switch response.result {
                case .success(let value):
                    if let dict = value as? NSDictionary {
                        let result = Result(result: dict)
                        if result.status == 200 {
                            observer.onNext(result)
                        } else {
                            self.showAlert(message: result.message)
                            ACProgressHUD.hide()
                        }
                        
                    }
                case .failure(let error):
                    print(error)
                    self.showAlert(message: "Lỗi mạng mời bạn kiểm tra lại")
                    ACProgressHUD.hide()
                }
                observer.onCompleted()
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func requestGet(path: String, method: HTTPMethod, params: Parameters!) -> Observable<Result> {
        // Set timeout for 3'
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 180
        
        let url = URL(string: "\(API.serverURL)\(path)")
        return Observable.create {
            observer in
            let request = Alamofire.request(url!, method: method, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON {
                response in
                switch response.result {
                case .success(let value):
                    if let dict = value as? NSDictionary {
                        let result = Result(result: dict)
                        if result.status == 200 {
                            observer.onNext(result)
                        } else {
                            self.showAlert(message: result.message)
                            ACProgressHUD.hide()
                        }
                        
                    }
                case .failure(let error):
                    print(error)
                    self.showAlert(message: "Lỗi mạng mời bạn kiểm tra lại")
                    ACProgressHUD.hide()
                }
                observer.onCompleted()
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
   
    func requestUploadImage(path: String, image: UIImage, method: HTTPMethod, params: Parameters!, completion: ((_ result: Result) -> Void)?)
    {
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 180
        
        let imgData = UIImageJPEGRepresentation(image, 0.2)!
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "files[]", fileName: "file.jpg", mimeType: "image/jpg")
            if params != nil {
                for (key, value) in params {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }
        }, to: "\(API.serverURL)\(path)")
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    if let dict = response.result.value as? NSDictionary {
                        let result = Result(result: dict)
                        if result.status == 200 {
                            completion?(result)
                        } else {
                            
                            ACProgressHUD.hide()
                        }
                    }
                    else
                    {
                        self.showAlert(message: "Gặp vấn đề khi tải ảnh mời bạn thử lại")
                        ACProgressHUD.hide()
                    }
                }
                
            case .failure(let encodingError):
                print(encodingError)
                self.showAlert(message: "Lỗi mạng mời bạn kiểm tra lại")
                ACProgressHUD.hide()
                
            }
        }
        
    }
    
    
    //======================================================
    //MARK: - Request error
    
    //MARK: - Authen API
    
    func registerUser(email:String,username:String,password:String) -> Observable<Result>
    {
        let params: Parameters = [
            "email": email,
            "username": username,
            "password": password
            ] as Parameters
        return self.request(path: API.registerUser, method: .post, params: params)
    }
    
    func login(username: String, password: String) -> Observable<Result> {
        let params: Parameters = [
            "username": username,
            "password": password
            ] as Parameters
        return self.requestGet(path: API.loginUser, method: .get, params: params)
    }
    
    func getCity() -> Observable<Result> {
        return self.requestGet(path: API.getCity, method: .get, params: nil)
    }
    
    func loginFB(fbid:String,name:String)-> Observable<Result>
    {
        let params: Parameters = [
            "fbid": fbid
//            "name":name
            ] as Parameters
        return self.requestGet(path: API.loginFB, method: .get, params: params)
    }
    
    func loginGG(email:String,fbid:String,name:String)-> Observable<Result>
    {
        let params: Parameters = [
            "email":email,
            "ggid": fbid,
            "name":name
            ] as Parameters
        return self.requestGet(path: API.loginGG, method: .get, params: params)
    }
    
    func showAlert(message: String) {
        _ = UIAlertView.show(withTitle: "", message: NSLocalizedString(message, comment: ""), cancelButtonTitle: "OK", otherButtonTitles: nil, tap: nil)
    }

}
