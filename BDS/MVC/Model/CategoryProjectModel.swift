//
//  CategoryProjectModel.swift
//  BDS
//
//  Created by Duy Huy on 12/4/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import ObjectMapper

class CategoryProjectModel: Mappable {

    var id =  ""
    var type =  ""
    var name =  ""
    var alias =  ""
    var alias_wrapper =  ""
    var parent_id =  ""
    var list_parents =  ""
    var level =  ""
    var published =  ""
    var ordering =  ""
    var image =  ""
    var created_time =  ""
    var updated_time =  ""
    var seo_title =  ""
    var seo_keyword =  ""
    var seo_description =  ""
    var lang =  ""
    var show_in_homepage =  ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.type <- map["type"]
        self.name <- map["name"]
        self.alias <- map["alias"]
        self.alias_wrapper <- map["alias_wrapper"]
        self.parent_id <- map["parent_id"]
        self.list_parents <- map["list_parents"]
        self.level <- map["level"]
        self.published <- map["published"]
        self.ordering <- map["ordering"]
        self.image <- map["image"]
        self.created_time <- map["created_time"]
        self.updated_time <- map["updated_time"]
        self.seo_title <- map["seo_title"]
        self.seo_keyword <- map["seo_keyword"]
        self.seo_description <- map["seo_description"]
        self.lang <- map["lang"]
        self.show_in_homepage <- map["show_in_homepage"]
    }
}
