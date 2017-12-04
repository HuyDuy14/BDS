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
    var image =  ""
    var address =  ""
    var introduce =  ""
    var info =  ""
    var summary =  ""
    var isLike:Bool = false
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.title <- map["title"]
        self.image <- map["image"]
        self.address <- map["address"]
        self.introduce <- map["introduce"]
        self.info <- map["info"]
        self.summary <- map["summary"]
    }
}
