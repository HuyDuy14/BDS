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
    
    func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailCheck = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailCheck.evaluate(with: email)
    }

}
