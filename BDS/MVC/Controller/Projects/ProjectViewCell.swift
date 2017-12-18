//
//  ProjectViewCell.swift
//  BDS
//
//  Created by Duy Huy on 12/1/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

protocol ProjectViewCellDelegate:class
{
    func saveProject(_ cell:ProjectViewCell,project:ProjectsModel,index:Int,type:Int)
    func saveLand(_ cell:ProjectViewCell,project:LandSaleModel,index:Int,type:Int)
}

class ProjectViewCell: UITableViewCell {

    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var information: UILabel!
    @IBOutlet weak var imageLike: UIImageView!
    @IBOutlet weak var btnLike: UIButton!
    var project:ProjectsModel!
    var land:LandSaleModel!
    var index:Int = 0
    var type:Int = 2
    weak var delegate:ProjectViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func loadData(project:ProjectsModel,index:Int,type:Int)
    {
        self.project = project
        self.index = index
        self.type = type
        self.imageViewProfile.setImageProject(urlString: API.linkImage + project.image)
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

    func loadDataHome(project:LandSaleModel,index:Int,type:Int)
    {
        self.land = project
        self.index = index
        self.type = type
        self.imageViewProfile.setImageProject(urlString: API.linkImage + project.image)
        self.name.text = project.title
        self.information.text = project.content
        var count = 0
        for land in Util.shared.listBDS
        {
            if land.id == project.id{
                project.isLike = true
                 self.imageLike.tintColor = UIColor.red
            }
            else
            {
                count += 1
            }
        }
        if count == Util.shared.listBDS.count
        {
             self.imageLike.tintColor = UIColor.lightGray
            project.isLike = false
        }
    }

    @IBAction func saveProjectButtonDidTap(_ sender: Any) {
        if self.project != nil
        {
            self.delegate?.saveProject(self, project: self.project, index: self.index, type: self.type)
        }
        else
        {
            self.delegate?.saveLand(self, project: self.land, index: self.index, type: self.type)
        }
    }
}
