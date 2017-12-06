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
    
    var id =  ""
    var title =  ""
    var image =  ""
    var address =  ""
    var email =  ""
    var phone =  ""
    var website =  ""
    var summary =  ""
    var content =  ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.title <- map["title"]
        self.image <- map["image"]
        self.address <- map["address"]
        self.email <- map["email"]
        self.phone <- map["phone"]
        self.website <- map["website"]
        self.summary <- map["summary"]
        self.content <- map["content"]
    }
}
