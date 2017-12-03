//
//  BrokerModel.swift
//  BDS
//
//  Created by Duy Huy on 12/3/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import ObjectMapper

class BrokerModel: Mappable {
    var title:String = ""
    var id: String = ""
    var image:String = ""
    var email:String = ""
    var phone = ""
    var website = ""
    var summary = ""
    var content = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id  <- map["id"]
        image  <- map["image"]
        title  <- map["title"]
        email  <- map["email"]
        phone  <- map["phone"]
        website <- map["website"]
        summary  <- map["summary"]
        content  <- map["content"]
    }
}
