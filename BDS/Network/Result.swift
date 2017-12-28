
//
//  Result.swift
//  Tracking
//
//  Created by Duy Huy on 10/13/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class Result:NSObject {
    
    var status: Int!
    var message: String = ""
    var data: [String : Any]?
    var dataArray:NSArray =  NSArray()
    var error:NSError!
    var url:String!
    var price:Int = 0
    
    internal init(error:NSError) {
        self.error = error
    }
    
    internal  init(result:NSDictionary) {
        self.status = result.object(forKey: "errorId") as? Int
        self.message = (result.object(forKey: "message") as? String) ?? ""
        if let data = result.object(forKey: "data")  as? [String : Any] {
            self.data = data
        } else {
            if let array = result.object(forKey: "data")  as? NSArray
            {
                self.dataArray = array
            }
            else
            {
                self.price = (result.object(forKey: "data") as? Int) ?? 0
            }
        }
    }
}

