//
//  ProjectViewCell.swift
//  BDS
//
//  Created by Duy Huy on 12/1/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class ProjectViewCell: UITableViewCell {

    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var information: UILabel!
    @IBOutlet weak var imageLike: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func loadData(project:ProjectsModel)
    {
        let url = URL(string: (API.linkImage + project.image).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        self.imageViewProfile.setImageProject(url: url)
        self.name.text = project.title
        self.information.text = project.address
        if project.isLike == true
        {
            self.imageLike.tintColor = UIColor.red
        }
        else
        {
            self.imageLike.tintColor = UIColor.lightGray
        }
    }
 
}
