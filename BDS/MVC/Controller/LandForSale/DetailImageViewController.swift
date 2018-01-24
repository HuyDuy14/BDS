//
//  DetailImageViewController.swift
//  BDS
//
//  Created by Duy Huy on 1/24/18.
//  Copyright © 2018 Duy Huy. All rights reserved.
//

import UIKit

class DetailImageViewController: UIViewController {

    var image:UIImage!
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.scrollView.delegate = self
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 5.0
        self.showImage.image = self.image
    }

    @IBAction func closeButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension DetailImageViewController:UIScrollViewDelegate
{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.showImage
    }
}
