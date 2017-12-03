//
//  NewsViewCell.swift
//  BDS
//
//  Created by Duy Huy on 12/1/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
protocol NewsViewCellDelegate:class
{
    func saveNews(_ cell:NewsViewCell,news:NewsModel,index:Int)
}

class NewsViewCell: UITableViewCell {

    @IBOutlet weak var btnSaveNews: UIButton!
    @IBOutlet weak var dateCreate: UILabel!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var imageViewNews: UIImageView!
    
    weak var delegate:NewsViewCellDelegate?
    var news:NewsModel!
    var index:Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func loadDataCell(news:NewsModel,index:Int)
    {
        self.index = index
        self.news = news
        self.imageViewNews.setImageUrlNews(url:API.linkImage + news.image )
        self.titleView.text = news.title
        self.dateCreate.text = news.created_time.FromStringToDateToStringNews()
    }
    
    @IBAction func saveNewsButtonDidTap(_ sender: Any) {
        self.delegate?.saveNews(self, news: self.news,index: self.index)
    }
    
}
