//
//  ImageViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/13/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var imageHome: UIImageView!
    var urlImage = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageHome.setImageUrlNews(url: API.linkImage + urlImage)
    }

   
}
