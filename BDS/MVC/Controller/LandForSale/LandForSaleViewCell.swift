//
//  LandForSaleViewCell.swift
//  BDS
//
//  Created by Duy Huy on 12/1/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
protocol LandForSaleViewCellDelegate:class
{
    func deleteSaveNews(_ cell:LandForSaleViewCell,news:NewsModel,index:Int,type:Int)
    func deleteSaveProject(_ cell:LandForSaleViewCell,project:ProjectsModel,index:Int,type:Int)
    func deleteSaveLand(_ cell:LandForSaleViewCell,land:LandSaleModel,index:Int,type:Int)
}

class LandForSaleViewCell: UITableViewCell {

    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var information: UILabel!
    @IBOutlet weak var imageLike: UIImageView!
    
    var news:NewsModel!
    var indexNews:Int = 0
    var type:Int = 1
    weak var delegate:LandForSaleViewCellDelegate?
    var land:LandSaleModel!
    var project:ProjectsModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func loadDataProject(project:ProjectsModel,index:Int,type:Int)
    {
        
        self.project  = project
        self.imageViewProfile.setImageProject(urlString: API.linkImage + project.image)
        self.name.text = project.title
        self.information.text = project.address
        self.indexNews = index
        self.type = type
        if project.isLike == true
        {
            self.imageLike.tintColor = UIColor.red
        }
        else
        {
            self.imageLike.tintColor = UIColor.lightGray
        }
    }
    
    func loadDataCell(cell:LandSaleModel,index:Int,type:Int)
    {
        self.indexNews = index
        self.type = type
        self.land = cell
        self.imageViewProfile.setImageUrlNews(url: API.linkImage + cell.image)
        self.name.text = cell.title
        self.information.text = cell.content
        var count = 0
        for land in Util.shared.listBDS
        {
            if land.id == cell.id{
                self.imageLike.tintColor = UIColor.red
                cell.isLike = true
            }
            else
            {
                count += 1
            }
        }
        if count == Util.shared.listBDS.count
        {
            cell.isLike = false
            self.imageLike.tintColor = UIColor.lightGray
        }
    }
    
    
    func loadDataNewsCell(cell:NewsModel,index:Int,type:Int)
    {
        self.news = cell
        self.indexNews = index
        self.type = type
        self.imageViewProfile.setImageUrlNews(url: API.linkImage + cell.image)
        self.name.text = cell.title
        self.information.text = cell.summary
    }
   
    @IBAction func deleteSaveNews(_ sender: Any) {
        if self.news != nil
        {
            self.delegate?.deleteSaveNews(self, news: self.news, index: self.indexNews,type: self.type)
        }
        if self.project != nil
        {
            self.delegate?.deleteSaveProject(self, project: self.project, index: self.indexNews, type: self.type)
        }
        if self.land != nil
        {
            self.delegate?.deleteSaveLand(self, land: self.land, index: self.indexNews, type: self.type)
        }
    }
  
}
