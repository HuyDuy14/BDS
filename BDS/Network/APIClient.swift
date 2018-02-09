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
import ACProgressHUD_Swift

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
                            if result.message.count != 0 {
                                self.showAlert(message: result.message)
                            }
                            
                            ACProgressHUD.shared.hideHUD()
                        }
                        
                    }
                case .failure(let error):
                    print(error)
                    self.showAlert(message: "Lỗi mạng mời bạn kiểm tra lại")
                    ACProgressHUD.shared.hideHUD()
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
                            if result.message.count != 0 {
                                self.showAlert(message: result.message)
                            }
                            ACProgressHUD.shared.hideHUD()
                        }
                        
                    }
                case .failure(let error):
                    print(error)
                    self.showAlert(message: "Lỗi mạng mời bạn kiểm tra lại")
                    ACProgressHUD.shared.hideHUD()
                }
                observer.onCompleted()
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func requestLoginGet(path: String, method: HTTPMethod, params: Parameters!) -> Observable<Result> {
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
                            if result.message.count != 0 {
                                AppDelegate.shared?.showMessagePopUp(title: "Đăng nhập thất bại", message: result.message)
                            }
                            ACProgressHUD.shared.hideHUD()
                        }
                        
                    }
                case .failure(let error):
                    print(error)
                    self.showAlert(message: "Lỗi mạng mời bạn kiểm tra lại")
                    ACProgressHUD.shared.hideHUD()
                }
                observer.onCompleted()
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    
    func requestUploadImage(path: String, image: UIImage?, method: HTTPMethod, params: Parameters!, completion: ((_ result: Result) -> Void)?)
    {
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 180
        if image == nil
        {
            let url = URL(string: "\(API.serverURL)\(path)")
            Alamofire.request(url!, method: method, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON {
                response in
                switch response.result {
                case .success(let value):
                    if let dict = value as? NSDictionary {
                        let result = Result(result: dict)
                        if result.status == 200 {
                            completion?(result)
                        } else {
                            if result.message.count != 0 {
                                AppDelegate.shared?.showMessagePopUp(title: "Đăng nhập thất bại", message: result.message)
                            }
                            ACProgressHUD.shared.hideHUD()
                        }
                        
                    }
                case .failure(let error):
                    print(error)
                    self.showAlert(message: "Lỗi mạng mời bạn kiểm tra lại")
                    ACProgressHUD.shared.hideHUD()
                }
            }
            return
        }
        let imgData = UIImageJPEGRepresentation(image!, 0.2)!
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "img", fileName: "file.jpg", mimeType: "image/jpg")
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
                        let result: Result = Result(result: dict)
                        if result.status == 200 {
                            completion?(result)
                        } else {
                            self.showAlert(message:result.message )
                            ACProgressHUD.shared.hideHUD()
                        }
                        
                    } else
                    {
                        self.showAlert(message: "Gặp vấn đề khi tải ảnh mời bạn thử lại")
                        ACProgressHUD.shared.hideHUD()
                    }
                }
                
            case .failure(let encodingError):
                print(encodingError)
                self.showAlert(message: "Lỗi mạng mời bạn kiểm tra lại")
                ACProgressHUD.shared.hideHUD()
                
            }
        }
        
    }
    
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
        return self.requestLoginGet(path: API.loginUser, method: .get, params: params)
    }
    
    func loginFB(fbid:String,name:String)-> Observable<Result>
    {
        let params: Parameters = [
            "fbid": fbid,
            "name":"",
            "email": ""
            ] as Parameters
        return self.requestLoginGet(path: API.loginFB, method: .get, params: params)
    }
    
    func forgotPass(email:String)-> Observable<Result>
    {
        let params: Parameters = [
            "email": email
            ] as Parameters
        return self.requestGet(path: API.forgotPass, method: .post, params: params)
    }
    
    func loginGG(email:String,fbid:String,name:String)-> Observable<Result>
    {
        let params: Parameters = [
            "email":email,
            "ggid": fbid,
            "name":name
            ] as Parameters
        return self.requestLoginGet(path: API.loginGG, method: .get, params: params)
    }
    
    func getCity() -> Observable<Result> {
        return self.requestGet(path: API.getCity, method: .get, params: nil)
    }
    
    func getDistrict(id:String) -> Observable<Result> {
        let params: Parameters = [
            "id":id
            ] as Parameters
        return self.requestGet(path: API.district, method: .get, params: params)
    }
    
    func getWard(id_city:String,id_district:String) -> Observable<Result> {
        let params: Parameters = [
            "id_city":id_city,
            "id_district":id_district
            ] as Parameters
        return self.requestGet(path: API.getWard, method: .get, params: params)
    }
    
    func getLandForSale(type:String) -> Observable<Result> {
        let params: Parameters = [
            "type":type
            ] as Parameters
        return self.requestGet(path: API.landForSale, method: .get, params: params)
    }
    
    func getNews(id:String,page:Int,isNews:Bool,isNewsBDS:Bool) -> Observable<Result> {
        let params: Parameters = [
            "id":id,
            "page":page
            ] as Parameters
        if isNews == true
        {
            if isNewsBDS == true
            {
                return self.requestGet(path: API.apiNewsLand, method: .get, params: params)
            }
            else
            {
                return self.requestGet(path: API.getNews, method: .get, params: params)
            }
        }
        else
        {
            return self.requestGet(path: API.getAdvise, method: .get, params: params)
        }
        
    }
    
    func getDetailSale(id:String) -> Observable<Result> {
        let params: Parameters = [
            "id":id
            ] as Parameters
        return self.requestGet(path: API.detailSale, method: .get, params: params)
    }
    
    func getDetailBorker(id:String) -> Observable<Result> {
        let params: Parameters = [
            "id":id
            ] as Parameters
        return self.requestGet(path: API.detailBroker, method: .get, params: params)
    }
    
    func getDetailNews(id:String,isNewsBDS:Bool) -> Observable<Result> {
        let params: Parameters = [
            "id":id
            ] as Parameters
        if isNewsBDS == true
        {
            return self.requestGet(path: API.apiDetailNewsBDS, method: .get, params: params)
        }
        else
        {
            return self.requestGet(path: API.detailNews, method: .get, params: params)
        }
    }
    func getDetailProject(id:String) -> Observable<Result> {
        let params: Parameters = [
            "id":id
            ] as Parameters
        return self.requestGet(path: API.detailProjrect, method: .get, params: params)
    }
    
    func getNewsSave(isMenu:Bool) -> Observable<Result> {
        let params: Parameters = [
            "id":Util.shared.currentUser.id
            ] as Parameters
        if isMenu == false
        {
            return self.requestGet(path: API.listNewsSave, method: .get, params: params)
        }
        else
        {
            return self.requestGet(path: API.listNewsPost, method: .get, params: params)
        }
    }
    
    func getAsvise(id:String) -> Observable<Result> {
        let params: Parameters = [
            "id":id
            ] as Parameters
        return self.requestGet(path: API.asviseDetail, method: .get, params: params)
    }
    
    func getListLandSale(page:Int) -> Observable<Result> {
        let params: Parameters = [
            "page":page
            ] as Parameters
        return self.requestGet(path: API.listLandSale, method: .get, params: params)
    }
    
    func getDataShowMaps(type:String,lat:String,lng:String,r:String) -> Observable<Result> {
        let params: Parameters = [
            "type":type,
            "lat":lat,
            "lng":lng,
            "r":r
            ] as Parameters
        return self.requestGet(path: API.mapsHome, method: .get, params: params)
    }
    
    func saveNews(id:String,type:Int) -> Observable<Result> {
        let params: Parameters =
            [
                "type":type,
                "id_news":id,
                "id_user":Util.shared.currentUser.id
                ] as Parameters
        return self.request(path: API.saveNews, method: .post, params: params)
    }
    
    func cancelNews(id:String,type:Int) -> Observable<Result> {
        let params: Parameters =
            [
                "type":type,
                "id_news":id,
                "id_user":Util.shared.currentUser.id
                ] as Parameters
        return self.request(path: API.cancelNews, method: .post, params: params)
    }
    
    func updateUserInfor(userInfor:UserModel,pass:String) -> Observable<Result> {
        var params: Parameters =
            [
                "id":userInfor.id,
                "phone":userInfor.poster_phone,
                "name":userInfor.username,
                "birthday":userInfor.birthday,
                "city_id":userInfor.city_id,
                "city_name":userInfor.city_name
                
                ] as Parameters
        if pass.count > 0
        {
            params["password"] = pass
        }
        return self.request(path: API.updateUser, method: .post, params: params)
    }
    
    func getCategoryNews() -> Observable<Result> {
        return self.requestGet(path: API.categoryNews, method: .get, params: nil)
    }
    
    func getCategoryAdvise() -> Observable<Result> {
        return self.requestGet(path: API.getCategoryAdvise, method: .get, params: nil)
    }
    
    func getCategoryProject() -> Observable<Result> {
        return self.requestGet(path: API.getTypeProject, method: .get, params: nil)
    }
    
    func getCategoryProjectOfCity(id:String) -> Observable<Result> {
        let params: Parameters = ["id":id]
        return self.requestGet(path: API.getprojectCity, method: .get, params: params)
    }
    
    func getCategoryLand(type:String) -> Observable<Result> {
        let params: Parameters = ["type":type]
        return self.requestGet(path: API.getCategoryLand, method: .get, params: params)
    }
    
    func searchProjects(idProject:Int,idCity:Int,idDistrict:Int,page:Int,nameProject:String) -> Observable<Result> {
        var params: Parameters = ["page":page,"title":nameProject]
        if idProject != 0
        {
            params["type"] = idProject
        }
        else
        {
            params["type"]  = "null"
        }
        if idCity != 0
        {
            params["city"] = idCity
        }
        else
        {
            params["city"] = "null"
        }
        if idDistrict != 0
        {
            params["district"] = idDistrict
        }
        else
        {
            params["district"] = "null"
        }
        
        return self.requestGet(path: API.searchProject, method: .get, params: params)
    }
    
    
    func searchLanForSent(type:String,idProject:String,idCity:String,idDistrict:String,page:Int) -> Observable<Result> {
        var params: Parameters = ["type":type,"page":page]
        params["type_bds"] = idProject
        params["city"] = idCity
        params["district"] = idDistrict
        return self.requestGet(path: API.searchBroker, method: .get, params: params)
    }
    
    func searchLandRent(project_id:String,title:String,type:String,city:String,ward:String,area_min:String,area_max:String,price_min:String,price_max:String,district:String,numberbedroom:String,direction:String,page:Int, isNewsApproved:Int,isGoverment:Int ,isWaitForSale:Int , isAvailability:Int) -> Observable<Result> {
        var params: Parameters = ["page":page]
        params["project_id"] = project_id
        params["title"] = title
        params["type"] = type
        params["city"] = city
        params["ward"] = ward
        params["area_min"] = area_min
        params["area_max"] = area_max
        params["price_min"] = price_min
        params["price_max"] = price_max
        params["district"] = district
        params["numberbedroom"] = numberbedroom
        params["direction"] = direction
        params["conhang"] = isWaitForSale
        params["hangchoban"] = isAvailability
        params["chinhchu"] = isGoverment
        params["tindaduyet"] = isNewsApproved
        return self.requestGet(path: API.searchLandRent, method: .get, params: params)
    }
    
    func searchLandSale(project_id:String,title:String,type:String,city:String,ward:String,area_min:String,area_max:String,price_min:String,price_max:String,district:String,numberbedroom:String,direction:String,page:Int,isNewsApproved:Int,isGoverment:Int ,isWaitForSale:Int , isAvailability:Int) -> Observable<Result> {
        var params: Parameters = ["page":page]
        params["project_id"] = project_id
        params["title"] = title
        params["type"] = type
        params["city"] = city
        params["ward"] = ward
        params["area_min"] = area_min
        params["area_max"] = area_max
        params["price_min"] = price_min
        params["price_max"] = price_max
        params["district"] = district
        params["numberbedroom"] = numberbedroom
        params["direction"] = direction
        params["conhang"] = isWaitForSale
        params["hangchoban"] = isAvailability
        params["chinhchu"] = isGoverment
        params["tindaduyet"] = isNewsApproved
        return self.requestGet(path: API.searchLandSale, method: .get, params: params)
    }
    
    func registerNews(project_id:String,type_bds:String,type:String,city:String,ward:String,area_min:String,area_max:String,price_min:String,price_max:String,district:String,numberbedroom:String,direction:String,email:String) -> Observable<Result> {
        
        var params: Parameters = [:]
        params["project_id"] = project_id
        params["type_bds"] = type_bds
        params["type"] = type
        params["city"] = city
        params["ward"] = ward
        params["area_min"] = area_min
        params["area_max"] = area_max
        params["price_min"] = price_min
        params["price_max"] = price_max
        params["district"] = district
        params["id_user"] = Util.shared.currentUser.id
        params["numberbedroom"] = numberbedroom
        params["direction"] = direction
        params["email"] = email
        
        return self.requestGet(path: API.registerNews, method: .post, params: params)
    }
    
    func getPrice(start:String,finish:String,type:Int)-> Observable<Result>
    {
        var params: Parameters = ["type":type]
        params["start"] = start
        params["finish"] = finish
        return self.requestGet(path: API.getPrice, method: .get, params: params)
    }
    
    func postNews(post_type:Int,startDate:String,endDate:String,user_type:String,title:String,project_id:String,type_bds:String,type:String,city:String,ward:String,area:String,price:String,price_type:String,district:String,address:String,des:String,numberbedroom:String,direction:String,image:UIImage!,poster_name:String,poster_address:String ,poster_phone:String,poster_mobile:String,poster_email:String,toilet:String,hbc:String,st:String,sndx:String,nt:String,dc:String,dv:String,mt:String, completion: ((_ result: Result) -> Void)?) {
        
        var params: Parameters = ["user_type":user_type,"title":title,"address":address,"des":des]
        params["project_id"] = project_id
        params["type_bds"] = type_bds
        params["type"] = type
        params["city_id"] = city
        params["ward_id"] = ward
        params["area"] = area
        params["price"] = price
        params["price_type"] = price_type
        params["district_id"] = district
        params["id"] = Util.shared.currentUser.id
        params["numberbedroom"] = numberbedroom
        params["direction"] = direction
        params["post_type"] = String(post_type)
        params["start"] = startDate
        params["finish"] = endDate
        params["poster_name"] = poster_name
        params["poster_address"] = poster_address
        params["poster_phone"] = poster_phone
        params["poster_mobile"] = poster_mobile
        params["poster_email"] = poster_email
        params["toilet"] = toilet
        params["hbc"] = hbc
        params["st"] = st
        params["sndx"] = sndx
        params["dc"] = dc
        params["nt"] = nt
        params["dv"] = dv
        params["mt"] = mt
        
        self.requestUploadImage(path: API.postNews, image: image, method: .post, params: params, completion: { result in
            completion?(result)
        })
        
    }
    
    func getNewsPost(page:Int)-> Observable<Result> {
        let params: Parameters = [
            "id":Util.shared.currentUser.id
            ] as Parameters
        return self.requestGet(path: API.listNewsPost, method: .get, params: params)
    }
    
    
    func getProject(page:Int)-> Observable<Result> {
        let params: Parameters = [
            "page":page
            ] as Parameters
        return self.requestGet(path: API.getProject, method: .get, params: params)
    }
    
    func showAlert(message: String) {
        _ = UIAlertView.show(withTitle: "", message: NSLocalizedString(message, comment: ""), cancelButtonTitle: "OK", otherButtonTitles: nil, tap: nil)
    }
    
}

