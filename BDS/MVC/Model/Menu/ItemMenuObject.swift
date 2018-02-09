//
//  ItemMenuObject.swift
//  CallDocter
//
//  Created by DevOminext on 5/22/17.
//  Copyright © 2017 HuyDuy. All rights reserved.
//

import UIKit

class ItemMenuObject: NSObject {

    var nameMenu:String!
    var imageMenu:String!
    var id:Int = 0
    var numberChat = 0;
    
    internal init(id:Int,nameMenu:String!, image:String!) {
        self.nameMenu = nameMenu
        self.imageMenu = image
        self.id = id
    }
    
}
