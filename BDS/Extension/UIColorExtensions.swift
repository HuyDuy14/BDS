//
//  UIColorExtensions.swift
//  SocialNetwork
//
//  Created by Duy Huy on 10/15/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

let COLOR_NAVI =  UIColor(netHex:0x42a8d1)
extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex: Int) {
        self.init(red: (netHex >> 16) & 0xff, green: (netHex >> 8) & 0xff, blue: netHex & 0xff)
    }
    
    convenience init(hex: String, alpha: CGFloat = 1) {
        var cString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            cString = (cString as NSString).substring(from: 1)
        }
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}


