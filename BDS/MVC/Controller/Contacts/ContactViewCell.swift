//
//  ContactViewCell.swift
//  BDS
//
//  Created by Duy Huy on 12/1/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class ContactViewCell: UITableViewCell {

    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var information: UILabel!
    @IBOutlet weak var phone: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadData(contact:BrokerModel)
    {
        self.imageViewProfile.setImageUrlNews(url: API.linkImage + contact.image)
        self.name.text = contact.title
        if contact.phone.count == 0 {
            self.phone.text = ""
        }
        else
        {
            self.phone.text = "Di động: " + contact.phone
        }
        self.information.text = "Email: " + contact.email
    }

    deinit {
        print("a")
    }

}
