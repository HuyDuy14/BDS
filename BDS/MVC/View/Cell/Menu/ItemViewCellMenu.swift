//
//  ItemViewCellMenu.swift
//  CallDocter
//
//  Created by DevOminext on 5/22/17.
//  Copyright © 2017 HuyDuy. All rights reserved.
//

import UIKit

class ItemViewCellMenu: UITableViewCell {

    @IBOutlet weak var imageMenu: UIImageView!
    @IBOutlet weak var nameMenu: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func initData(_ item: ItemMenuObject!){
        self.nameMenu.text = item.nameMenu
        self.imageMenu.image = UIImage(named: item.imageMenu)
        self.imageMenu.layer.cornerRadius = 15
        self.imageMenu.layer.masksToBounds = true
       
    }

}
