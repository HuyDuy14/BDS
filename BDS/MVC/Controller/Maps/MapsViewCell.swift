//
//  MapsViewCell.swift
//  BDS
//
//  Created by Duy Huy on 12/8/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class MapsViewCell: UITableViewCell {

    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var information: UILabel!
    @IBOutlet weak var imageLike: UIImageView!
    
    var type:String = "sale"
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
        self.name.text  = cell.title
        cell.content = cell.content.replacingOccurrences(of: "&amp;lt;p&amp;gt;", with: "")
        self.information.attributedText = cell.content.convertHtml()
        if self.type == "project"
        {
            self.information.attributedText = cell.investor.convertHtml()
        }
        if cell.isLike == true
        {
            self.imageLike.tintColor = UIColor.red
        }
        else
        {
            self.imageLike.tintColor = UIColor.lightGray
        }
        self.imageViewProfile.isHidden = false
        self.imageLike.isHidden = false
        self.viewLine.isHidden = false
    }
    func loadDataCell()
    {
        self.imageViewProfile.isHidden = true
        self.name.text  = ""
        self.information.text = ""
        self.imageLike.isHidden = true
        self.viewLine.isHidden = true
    }
    
    func loadDataNewsCell(cell:NewsModel,index:Int)
    {
        self.news = cell
        self.indexNews = index
        self.imageViewProfile.setImageUrlNews(url: API.linkImage + cell.image)
        self.name.attributedText = cell.title.convertHtml()
        self.information.attributedText = cell.summary.convertHtml()
    }

    @IBAction func saveButtonDidTap(_ sender: Any) {
        
    }
    
   
}
