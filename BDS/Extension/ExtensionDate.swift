//
//  ExtensionDate.swift
//  SocialNetwork
//
//  Created by Duy Huy on 11/14/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

import Foundation

extension Date
{
    func dateFormatString(formater:String)->String
    {
        let dateformater = DateFormatter()
        dateformater.dateFormat = formater
        return dateformater.string(from: self)
    }
    
    public var formatDateDD:String {
        let dateformater = DateFormatter()
        dateformater.dateFormat = "dd-MM-yyyy"
        return dateformater.string(from: self)
    }
}
