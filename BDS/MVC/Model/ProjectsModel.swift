//
//  ProjectsModel.swift
//  BDS
//
//  Created by Duy Huy on 12/4/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import ObjectMapper
class ProjectsModel: Mappable {
    
    var id =  ""
    var title =  ""
    var alias = ""
    var image =  ""
    var address =  ""
    var investor =  ""
    var lat =  ""
    var lng =  ""
    var date_start =  ""
    var date_finish =  ""
    var poster_name =  ""
    var poster_avatar =  ""
    var poster_address =  ""
    var poster_phone =  ""
    var poster_email =  ""
    var poster_mobile =  ""
    var company_logo =  ""
    var company_name =  ""
    var company_phone =  ""
    var company_website =  ""
    var area =  ""
    var land_area =  ""
    var created_time =  ""
    var price =  ""
    var post_transfer_ground_price =  ""
    var land_price =  ""
    var land_pricereal =  ""
    var introduce =  ""
    var info =  ""
    var info_investor =  ""
    var design =  ""
    var summary =  ""
    var content =  ""
    var list_image:[String] = []
    var isLike:Bool = false
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.alias <- map["alias"]
        self.title <- map["title"]
        self.image <- map["image"]
        self.address <- map["address"]
        self.investor <- map["investor"]
        self.lat <- map["lat"]
        self.lng <- map["lng"]
        self.date_start <- map["date_start"]
        self.date_finish <- map["date_finish"]
        self.poster_name <- map["poster_name"]
        self.poster_avatar <- map["poster_avatar"]
        self.poster_address <- map["poster_address"]
        self.poster_phone <- map["poster_phone"]
        self.poster_email <- map["poster_email"]
        self.poster_mobile <- map["poster_mobile"]
        self.company_logo <- map["company_logo"]
        self.company_name <- map["company_name"]
        self.company_phone <- map["company_phone"]
        self.company_website <- map["company_website"]
        self.area <- map["area"]
        self.land_area <- map["land_area"]
        self.created_time <- map["created_time"]
        self.price <- map["price"]
        self.post_transfer_ground_price <- map["post_transfer_ground_price"]
        self.land_price <- map["land_price"]
        self.land_pricereal <- map["land_pricereal"]
        self.introduce <- map["introduce"]
        self.info <- map["info"]
        self.info_investor <- map["info_investor"]
        self.design <- map["design"]
        self.summary <- map["summary"]
        self.content <- map["content"]
        self.list_image <- map["list_image"]
    }
}
