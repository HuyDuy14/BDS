
//
//  LandSaleModel.swift
//  BDS
//
//  Created by Duy Huy on 12/4/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import ObjectMapper

class LandSaleModel: Mappable {
    var id =  ""
    var title =  ""
    var alias =  ""
    var image =  ""
    var type =  ""
    var address =  ""
    var code =  ""
    var member_type =  ""
    var land_style =  ""
    var category_id =  ""
    var category_alias =  ""
    var category_name =  ""
    var category_id_wrapper =  ""
    var category_alias_wrapper =  ""
    var land_form =  ""
    var project_name =  ""
    var project_website =  ""
    var post_page_transfer =  ""
    var post_transfer_ground_price =  ""
    var post_average_revenue =  ""
    var regions_id =  ""
    var city_id =  ""
    var city_name =  ""
    var district_id =  ""
    var district_name =  ""
    var street_id =  ""
    var street_name =  ""
    var ward_id =  ""
    var ward_name =  ""
    var home_number =  ""
    var land_length =  ""
    var land_width =  ""
    var land_area =  "0"
    var land_area_type =  ""
    var land_legal_status =  ""
    var land_price =  ""
    var land_pricem2 =  ""
    var land_negotiate =  ""
    var land_floor =  ""
    var land_direction =  ""
    var land_bedroom =  ""
    var land_high_road =  ""
    var land_toilet =  ""
    var land_facade =  ""
    var land_gara =  ""
    var post_type =  ""
    var land_date_start =  ""
    var land_date_finish =  ""
    var land_lat =  "0"
    var land_lng =  "0"
    var land_zoom =  ""
    var land_video =  ""
    var poster_id =  ""
    var poster_name =  ""
    var poster_avatar =  ""
    var poster_address =  ""
    var poster_phone =  ""
    var poster_email =  ""
    var poster_mobile =  ""
    var poster_avarta =  ""
    var poster_background_color =  ""
    var poster_text_color =  ""
    var poster_facebook =  ""
    var company_logo =  ""
    var company_name =  ""
    var company_mobile =  ""
    var company_phone =  ""
    var company_fax =  ""
    var company_website =  ""
    var company_address =  ""
    var content =  ""
    var content_special =  ""
    var legal_procedures =  ""
    var payment_method =  ""
    var discounted_deals =  ""
    var form_house =  ""
    var times_week =  ""
    var new =  ""
    var hot =  ""
    var featured =  ""
    var ordering =  ""
    var published =  ""
    var viewed =  ""
    var created_time =  ""
    var seo_title =  ""
    var seo_keyword =  ""
    var seo_description =  ""
    var poster_mphone =  ""
    var location =  ""
    var area =  ""
    var member_type2 =  ""
    var member_type3 =  ""
    var member_type4 =  ""
    var land_place =  ""
    var project_id =  ""
    var tag =  ""
    var land_bath =  ""
    var land_direction_bc =  ""
    var land_pricereal =  ""
    var land_price_type =  ""
    var furniture =  ""
    var lang =  ""
    var land_area_need_min =  ""
    var land_area_need_max =  ""
    var land_price_need_min =  ""
    var land_price_need_max =  ""
    var image_panorama =  ""
    var total_pay =  ""
    var vat_pay =  ""
    var phi_pay =  ""
    var cn_dn =  ""
    var outweb =  ""
    var fs =  ""
    var source =  ""
    var trade =  ""
    var action_id =  ""
    var action_name =  ""
    var note_advert =  ""
    var conhang =  ""
    var hangchoban =  ""
    var investor = ""
    var list_image:[String] = []
    var isLike:Bool = false
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.investor <- map["investor"]
        self.title <- map["title"]
        self.alias <- map["alias"]
        self.image <- map["image"]
        self.type <- map["type"]
        self.code <- map["code"]
        self.address <- map["address"]
        self.member_type <- map["member_type"]
        self.land_style <- map["land_style"]
        self.category_id <- map["category_id"]
        self.category_alias <- map["category_alias"]
        self.category_name <- map["category_name"]
        self.category_id_wrapper <- map["category_id_wrapper"]
        self.category_alias_wrapper <- map["category_alias_wrapper"]
        self.land_form <- map["land_form"]
        self.project_name <- map["project_name"]
        self.project_website <- map["project_website"]
        self.post_page_transfer <- map["post_page_transfer"]
        self.post_transfer_ground_price <- map["post_transfer_ground_price"]
        self.post_average_revenue <- map["post_average_revenue"]
        self.regions_id <- map["regions_id"]
        self.city_id <- map["city_id"]
        self.city_name <- map["city_name"]
        self.district_id <- map["district_id"]
        self.district_name <- map["district_name"]
        self.street_id <- map["street_id"]
        self.street_name <- map["street_name"]
        self.ward_id <- map["ward_id"]
        self.ward_name <- map["ward_name"]
        self.home_number <- map["home_number"]
        self.land_length <- map["land_length"]
        self.land_width <- map["land_width"]
        self.land_area <- map["land_area"]
        self.land_area_type <- map["land_area_type"]
        self.land_legal_status <- map["land_legal_status"]
        self.land_price <- map["land_price"]
        self.land_pricem2 <- map["land_pricem2"]
        self.land_negotiate <- map["land_negotiate"]
        self.land_floor <- map["land_floor"]
        self.land_direction <- map["land_direction"]
        self.land_bedroom <- map["land_bedroom"]
        self.land_high_road <- map["land_high_road"]
        self.land_toilet <- map["land_toilet"]
        self.land_facade <- map["land_facade"]
        self.land_gara <- map["land_gara"]
        self.post_type <- map["post_type"]
        self.land_date_start <- map["land_date_start"]
        self.land_date_finish <- map["land_date_finish"]
        self.land_lat <- map["land_lat"]
        self.land_lng <- map["land_lng"]
        self.land_zoom <- map["land_zoom"]
        self.land_video <- map["land_video"]
        self.poster_id <- map["poster_id"]
        self.poster_name <- map["poster_name"]
        self.poster_avatar <- map["poster_avatar"]
        self.poster_address <- map["poster_address"]
        self.poster_phone <- map["poster_phone"]
        self.poster_email <- map["poster_email"]
        self.poster_mobile <- map["poster_mobile"]
        self.poster_avarta <- map["poster_avarta"]
        self.poster_background_color <- map["poster_background_color"]
        self.poster_text_color <- map["poster_text_color"]
        self.poster_facebook <- map["poster_facebook"]
        self.company_logo <- map["company_logo"]
        self.company_name <- map["company_name"]
        self.company_mobile <- map["company_mobile"]
        self.company_phone <- map["company_phone"]
        self.company_fax <- map["company_fax"]
        self.company_website <- map["company_website"]
        self.company_address <- map["company_address"]
        self.content <- map["content"]
        self.content_special <- map["content_special"]
        self.legal_procedures <- map["legal_procedures"]
        self.payment_method <- map["payment_method"]
        self.discounted_deals <- map["discounted_deals"]
        self.form_house <- map["form_house"]
        self.times_week <- map["times_week"]
        self.new <- map["new"]
        self.hot <- map["hot"]
        self.featured <- map["featured"]
        self.ordering <- map["ordering"]
        self.published <- map["published"]
        self.viewed <- map["viewed"]
        self.created_time <- map["created_time"]
        self.seo_title <- map["seo_title"]
        self.seo_keyword <- map["seo_keyword"]
        self.seo_description <- map["seo_description"]
        self.poster_mphone <- map["poster_mphone"]
        self.location <- map["location"]
        self.area <- map["area"]
        self.member_type2 <- map["member_type2"]
        self.member_type3 <- map["member_type3"]
        self.member_type4 <- map["member_type4"]
        self.land_place <- map["land_place"]
        self.project_id <- map["project_id"]
        self.tag <- map["tag"]
        self.land_bath <- map["land_bath"]
        self.land_direction_bc <- map["land_direction_bc"]
        self.land_pricereal <- map["land_pricereal"]
        self.land_price_type <- map["land_price_type"]
        self.furniture <- map["furniture"]
        self.lang <- map["lang"]
        self.land_area_need_min <- map["land_area_need_min"]
        self.land_area_need_max <- map["land_area_need_max"]
        self.land_price_need_min <- map["land_price_need_min"]
        self.land_price_need_max <- map["land_price_need_max"]
        self.image_panorama <- map["image_panorama"]
        self.total_pay <- map["total_pay"]
        self.vat_pay <- map["vat_pay"]
        self.phi_pay <- map["phi_pay"]
        self.cn_dn <- map["cn_dn"]
        self.outweb <- map["outweb"]
        self.fs <- map["fs"]
        self.source <- map["source"]
        self.trade <- map["trade"]
        self.action_id <- map["action_id"]
        self.action_name <- map["action_name"]
        self.note_advert <- map["note_advert"]
        self.conhang <- map["conhang"]
        self.hangchoban <- map["hangchoban"]
        self.list_image <- map["list_image"]
    }
    
}
