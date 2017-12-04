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
    
    func FromStringToDateToDate()->Date{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        return dateFormat.date(from: self)!
    }
    
    func FromStringToDateToStringNews()->String{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormat.date(from: self) ?? Date()
        dateFormat.dateFormat = "HH:mm dd-MM-yyyy"
        return dateFormat.string(from: date)
    }
    
}
