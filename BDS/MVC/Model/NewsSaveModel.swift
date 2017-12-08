//
//  NewsSaveModel.swift
//  BDS
//
//  Created by Duy Huy on 12/8/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import ObjectMapper

class NewsSaveModel: Mappable {

    var listNews:[NewsModel] = []
    var listProjects:[ProjectsModel] = []
    var listBDS:[LandSaleModel] = []
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.listNews <- map["news"]
        self.listProjects <- map["project"]
        self.listBDS <- map["bds"]
    }
}
