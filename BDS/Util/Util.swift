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
            let desString = baseHTML.replacingOccurrences(of: "Loading...", with: string)
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
