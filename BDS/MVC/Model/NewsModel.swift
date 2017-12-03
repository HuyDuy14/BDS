//
//  NewsModel.swift
//  BDS
//
//  Created by Duy Huy on 12/3/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import ObjectMapper

class NewsModel: Mappable {
    var title:String = ""
    var id: String = ""
    var image:String = ""
    var created_time:String = ""
    var category_name = ""
    var summary = ""
    var content = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id  <- map["id"]
        image  <- map["image"]
        title  <- map["title"]
        created_time  <- map["created_time"]
        category_name  <- map["category_name"]
        summary  <- map["summary"]
        content  <- map["content"]
    }
}
