//
//  ModelCity.swift
//  BDS
//
//  Created by Duy Huy on 12/2/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import ObjectMapper

class ModelCity: Mappable {

    var name:String = ""
    var id: String = ""
    var type:String = ""
    var published:String = ""
    var ordering = ""
    var alias = ""
    var country_id = ""
    var country_alias = ""
    var regions_id = ""
    var code = ""
    var shipping = ""
    
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
        country_id  <- map["country_id"]
        country_alias  <- map["country_alias"]
        regions_id  <- map["regions_id"]
        code  <- map["code"]
        shipping  <- map["shipping"]
    }
    
    
}
