//
//  CategoryNewsModel.swift
//  BDS
//
//  Created by Duy Huy on 12/4/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import ObjectMapper

class CategoryNewsModel: Mappable {
    var id =  ""
    var name =  ""
    var alias =  ""
    var category_id =  ""
    var alias_wrapper =  ""
    var parent_id =  ""
    var list_parents =  ""
    var level =  ""
    var published =  ""
    var ordering =  ""
    var image =  ""
    var icon =  ""
    var created_time =  ""
    var updated_time =  ""
    var show_in_homepage =  ""
    var estore_id =  ""
    var display_title =  ""
    var display_tags =  ""
    var display_related =  ""
    var display_created_time =  ""
    var display_category =  ""
    var display_comment =  ""
    var display_sharing =  ""
    var name_display =  ""
    var is_comment =  ""
    var notice =  ""
    var seo_title =  ""
    var seo_keyword =  ""
    var seo_description =  ""
    var lang =  ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.name <- map["name"]
        self.alias <- map["alias"]
        self.category_id <- map["category_id"]
        self.alias_wrapper <- map["alias_wrapper"]
        self.parent_id <- map["parent_id"]
        self.list_parents <- map["list_parents"]
        self.level <- map["level"]
        self.published <- map["published"]
        self.ordering <- map["ordering"]
        self.image <- map["image"]
        self.icon <- map["icon"]
        self.created_time <- map["created_time"]
        self.updated_time <- map["updated_time"]
        self.show_in_homepage <- map["show_in_homepage"]
        self.estore_id <- map["estore_id"]
        self.display_title <- map["display_title"]
        self.display_tags <- map["display_tags"]
        self.display_related <- map["display_related"]
        self.display_created_time <- map["display_created_time"]
        self.display_category <- map["display_category"]
        self.display_comment <- map["display_comment"]
        self.display_sharing <- map["display_sharing"]
        self.name_display <- map["name_display"]
        self.is_comment <- map["is_comment"]
        self.notice <- map["notice"]
        self.seo_title <- map["seo_title"]
        self.seo_keyword <- map["seo_keyword"]
        self.seo_description <- map["seo_description"]
        self.lang <- map["lang"]
    }
}
