//
//  Util.swift
//  BDS
//
//  Created by Duy Huy on 12/2/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class Util: NSObject {
    
    static var shared = Util()
    
    var currentUser:UserModel = UserModel()
    var listCity:[ModelCity] = []
    var listCategoryNews:[CategoryNewsModel] = []
    var listNewsSave :[NewsModel]  = []
    var listProjectSave:[ProjectsModel] = []
    var listBDS:[LandSaleModel] = []
    var typesProject:[CategoryProjectModel] = []
    var listCategorySale:[CategoryLand] = []
    var listCategoryRent:[CategoryLand] = []
    var listAllCategoryland:[CategoryLand] = []
    
    func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailCheck = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailCheck.evaluate(with: email)
    }
    
    func htmlString(from string: String) -> String {
       
        guard let filePath = Bundle.main.path(forResource: "news", ofType: "html") else {
            return string
        }
        
        do {
            let baseHTML = try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
            var desString = baseHTML.replacingOccurrences(of: "Loading...", with: string)
            let w = String(Int(UIScreen.main.bounds.size.width) - 60)
            desString = desString.replacingOccurrences(of: "96%", with: w)
            return desString
        } catch {
            return string
        }
        
    }
    func webViewChangeFont(htmlString: String) -> String {
        let newString = "<span style=\"font-family: helvetica; font-size: 16\">\(htmlString)</span>"
        return newString
    }

}
