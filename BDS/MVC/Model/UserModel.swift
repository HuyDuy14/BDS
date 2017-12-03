//
//  UserModel.swift
//  BDS
//
//  Created by Duy Huy on 12/3/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import ObjectMapper

class UserModel: Mappable {

    var id: String = ""
    var facebook_id = ""
    var ggid = ""
    var member_type = ""
    var username = ""
    var image = ""
    var birthday = ""
    var gender = ""
    var city_id = ""
    var city_name = ""
    var district_id = ""
    var district_name = ""
    var level = ""
    var email = ""
    var code = ""
    var point = ""
    var poster_avatar = ""
    var poster_name = ""
    var poster_mobile = ""
    var poster_phone = ""
    var poster_address = ""
    var summary_yourself = ""
    var poster_facebook = ""
    var company_name = ""
    var company_mobile = ""
    var company_phone = ""
    var company_fax = ""
    var company_website = ""
    var company_address = ""
    var company_logo = ""
    var company_longitude = ""
    var company_latitude = ""
    var company_zoom = ""
    var background_color = ""
    var text_color = ""
    var content = ""
    var money = ""
    var created_time = ""
    var edit_time = ""
    var ordering = ""
    var published = ""
    var category_id = ""
    var category_alias = ""
    var category_name = ""
    var category_alias_wrapper = ""
    var is_contact = ""
    var activated_code = ""
    var fields = ""
    var cmnd = ""
    var mst = ""
    var save_news = ""
    var category_id_wrapper = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id  <- map["id"]
        facebook_id <- map["facebook_id"]
        ggid <- map["ggid"]
        member_type <- map["member_type"]
        username <- map["username"]
        image <- map["image"]
        birthday <- map["birthday"]
        gender <- map["birthday"]
        city_id <- map["city_id"]
        city_name <- map["city_name"]
        district_id <- map["district_id"]
        district_name <- map["district_name"]
        level <- map["level"]
        email <- map["email"]
        code <- map["code"]
        point <- map["point"]
        poster_avatar <- map["poster_avatar"]
        poster_name <- map["poster_name"]
        poster_mobile <- map["poster_mobile"]
        poster_phone <- map["poster_phone"]
        poster_address <- map["poster_address"]
        summary_yourself <- map["summary_yourself"]
        poster_facebook <- map["poster_facebook"]
        company_name <- map["company_name"]
        company_mobile <- map["company_mobile"]
        company_phone <- map["company_phone"]
        company_fax <- map["company_fax"]
        company_website <- map["company_website"]
        company_address <- map["company_address"]
        company_logo <- map["company_logo"]
        company_longitude <- map["company_longitude"]
        company_latitude <- map["company_latitude"]
        company_zoom <- map["company_zoom"]
        background_color <- map["background_color"]
        text_color <- map["text_color"]
        content <- map["content"]
        money <- map["money"]
        created_time <- map["created_time"]
        edit_time <- map["edit_time"]
        ordering <- map["ordering"]
        published <- map["published"]
        category_id <- map["category_id"]
        category_alias <- map["category_alias"]
        category_name <- map["category_name"]
        category_alias_wrapper <- map["category_alias_wrapper"]
        is_contact <- map["is_contact"]
        activated_code <- map["activated_code"]
        fields <- map["fields"]
        cmnd <- map["cmnd"]
        mst <- map["mst"]
        save_news <- map["save_news"]
        category_id_wrapper <- map["category_id_wrapper"]
    }
    
    
}
