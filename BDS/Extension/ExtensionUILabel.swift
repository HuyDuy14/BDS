//
//  ExtensionUILabel.swift
//  BDS
//
//  Created by Duy Huy on 12/1/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

extension UILabel {
    func getLabelHeight() -> CGFloat {
        let constraint: CGSize = CGSize.init(width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude)
        let context: NSStringDrawingContext = NSStringDrawingContext()
        let str: NSString = NSString.init(string: self.text!)
        let boundingBox: CGSize = str.boundingRect(with: constraint, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: self.font], context: context).size
        let size = CGSize.init(width: ceil(boundingBox.width), height: ceil(boundingBox.height))
        
        return size.height
    }
}
