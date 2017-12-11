//
//  PopOverTypeMapsViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/8/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class PopOverTypeMapsViewController: BaseViewController {

    var finish:((_ index: Int)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let size = UIScreen.main.bounds
        self.preferredContentSize = CGSize(width:(size.width ) / 2 , height: 160 )
    }

    
    @IBAction func rentButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.finish!(2)
    }
    
    @IBAction func saleButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.finish!(3)
    }
    
    @IBAction func distanceButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.finish!(1)
    }
    @IBAction func projectButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.finish!(4)
    }
}
