//
//  ExtensionString.swift
//  SocialNetwork
//
//  Created by Duy Huy on 11/17/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

public extension String
{
    func FromStringToDateToString()->String{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm"
        let date = dateFormat.date(from: self) ?? Date()
        dateFormat.dateFormat = "yyyy-MM-dd"
        return dateFormat.string(from: date) 
    }
    
    func FromStringToDateToStringProjects()->String{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormat.date(from: self) ?? Date()
        dateFormat.dateFormat = "yyyy-MM-dd"
        return dateFormat.string(from: date)
    }
    
    func FromStringToDateToDate()->Date{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        return dateFormat.date(from: self) ?? Date()
    }
    
    func FromStringToDateToStringNews()->String{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormat.date(from: self) ?? Date()
        dateFormat.dateFormat = "HH:mm ngày dd/MM/yyyy"
        return dateFormat.string(from: date)
    }
    
    func FromStringToDateToDD()->String{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormat.date(from: self) ?? Date()
        dateFormat.dateFormat = "dd/"
        return dateFormat.string(from: date)
    }
    func FromStringToDateToMM()->String{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormat.date(from: self) ?? Date()
        dateFormat.dateFormat = "MM/"
        return dateFormat.string(from: date)
    }
    
    func FromStringToDateToYYYY()->String{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormat.date(from: self) ?? Date()
        dateFormat.dateFormat = "yyyy"
        return dateFormat.string(from: date)
    }
    
    public func isPhone()->Bool {
        if self.isAllDigits() == true {
            let phoneRegex = "^((\\+)|(0))[0-9]{6,14}$"
            let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return  predicate.evaluate(with: self)
        }else {
            return false
        }
    }
    
    func validate() -> Bool {
        let PHONE_REGEX = ""
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self)
        return result
    }
    
   func isAllDigits()->Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = self.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  self == filtered
    }
    
}

extension String{
    func convertHtml() -> NSAttributedString{
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do{
            return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue,NSFontAttributeName:  UIFont(name: "Helvetica-Bold", size: 14.0)!], documentAttributes: nil)
        }catch{
            return NSAttributedString()
        }
    }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8), options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
