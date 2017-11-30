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
    var header: HTTPHeaders = [
        "Authorization": "Basic b21paHJtOm9taW5leHQyMDE3"
        ] as HTTPHeaders
    
    //MARK: - Base function. Not change this section
    //======================================================
    func request(path: String, method: HTTPMethod, params: Parameters!) -> Observable<Result> {
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
                        if let result: Result = Result(result: dict) {
                            if result.status == 200 {
                                observer.onNext(result)
                            } else {
                                self.showAlert(message: result.message!)
                                //                                 observer.onNext(result)
                                ACProgressHUD.hide()
                            }
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
    
    func requestChat(path: String, method: HTTPMethod, params: Parameters!) -> Observable<Result> {
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
                        if let result: Result = Result(result: dict) {
                            if result.status == 200 {
                                observer.onNext(result)
                            } else {
                                ACProgressHUD.hide()
                            }
                        }
                    }
                case .failure(_):
                    //                    print(error)
                    //                    self.showAlert(message: "Lỗi mạng mời bạn kiểm tra lại")
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
                        if let result: Result = Result(result: dict) {
                            if result.status == 200 {
                                completion?(result)
                            } else {
                                ACProgressHUD.hide()
                            }
                        }
                    } else
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
    func settingApp() -> Observable<Result> {
        return self.request(path: API.settingApp, method: .post, params: nil)
    }
    
    func login(nameUser: String, password: String) -> Observable<Result> {
        let params: Parameters = [
            "txtNameId": nameUser,
            "txtPassword": password,
            "type-send": 2
            ] as Parameters
        return self.request(path: API.settingApp, method: .post, params: params)
    }
    

    
    func showAlert(message: String) {
        _ = UIAlertView.show(withTitle: "", message: NSLocalizedString(message, comment: ""), cancelButtonTitle: "OK", otherButtonTitles: nil, tap: nil)
    }

}
