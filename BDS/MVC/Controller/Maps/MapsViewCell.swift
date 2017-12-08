//
//  MapsViewCell.swift
//  BDS
//
//  Created by Duy Huy on 12/8/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class MapsViewCell: UITableViewCell {

    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var information: UILabel!
    @IBOutlet weak var imageLike: UIImageView!
    
    var news:NewsModel!
    var indexNews:Int = 0
    weak var delegate:LandForSaleViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadDataCell(cell:LandSaleModel)
    {
        self.imageViewProfile.setImageUrlNews(url: API.linkImage + cell.image)
        self.name.text = cell.title
        self.information.text = cell.content
        if cell.isLike == true
        {
            self.imageLike.tintColor = UIColor.red
        }
        else
        {
            self.imageLike.tintColor = UIColor.lightGray
        }
    }
    
    func loadDataNewsCell(cell:NewsModel,index:Int)
    {
        self.news = cell
        self.indexNews = index
        self.imageViewProfile.setImageUrlNews(url: API.linkImage + cell.image)
        self.name.text = cell.title
        self.information.text = cell.summary
    }

   
}
