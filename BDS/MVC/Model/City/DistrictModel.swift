//
//  DistrictModel.swift
//  BDS
//
//  Created by Duy Huy on 12/3/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import ObjectMapper

class DistrictModel: Mappable {
    
    var name:String = ""
    var id: String = ""
    var type:String = ""
    var published:String = ""
    var ordering = ""
    var alias = ""
    var location = ""
    var city_id = ""
    var code = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id  <- map["id"]
        name  <- map["name"]
        type  <- map["type"]
        published  <- map["published"]
        ordering  <- map["ordering"]
        alias  <- map["alias"]
        location  <- map["location"]
        city_id  <- map["city_id"]
        code  <- map["code"]
    }
}

