//
//  ModelPicker.swift
//  Docter
//
//  Created by Huy Duy on 6/22/17.
//  Copyright © 2017 huy. All rights reserved.
//

import UIKit

class ModelPicker: NSObject {
    var id: Int!
    var name: String!
    var index:Int = 0 
    internal init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

