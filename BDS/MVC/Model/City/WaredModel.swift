//
//  WaredModel.swift
//  BDS
//
//  Created by Duy Huy on 12/7/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import ObjectMapper

class WaredModel: Mappable {
    var id =  ""
    var code =  ""
    var district_id =  ""
    var name =  ""
    var ordering =  ""
    var published =  ""
    var created_time =  ""
    var updated_time =  ""
    var alias =  ""
    var type =  ""
    var location =  ""
    var district_name =  ""
    var city_id =  ""
    var city_name =  ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.code <- map["code"]
        self.district_id <- map["district_id"]
        self.name <- map["name"]
        self.ordering <- map["ordering"]
        self.published <- map["published"]
        self.created_time <- map["created_time"]
        self.updated_time <- map["updated_time"]
        self.alias <- map["alias"]
        self.type <- map["type"]
        self.location <- map["location"]
        self.district_name <- map["district_name"]
        self.city_id <- map["city_id"]
        self.city_name <- map["city_name"]
    }
}
