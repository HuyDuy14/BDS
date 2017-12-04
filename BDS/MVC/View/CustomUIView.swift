//
//  CustomUIView.swift
//  CallDocter
//
//  Created by DevOminext on 5/22/17.
//  Copyright © 2017 HuyDuy. All rights reserved.
//

import UIKit
import ACProgressHUD_Swift
import UIAlertView_Blocks

let IMAGE_HOLDER = "user"
@IBDesignable
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    @IBInspectable var borderColor: UIColor? {
        get {
            return layer.borderColor == nil ? nil : UIColor(cgColor: layer.borderColor!)
        }
        set{
            layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set{
            layer.borderWidth = newValue
        }
    }
}


@IBDesignable
class CustomRoundButton: UIButton {
    func setColor(_ color: UIColor?) {
        if color != nil && imageView?.image != nil
            && imageView?.image?.renderingMode != .alwaysTemplate {
            imageView?.tintColor = color
            imageView?.image = imageView?.image?.withRenderingMode(.alwaysTemplate)
        }
    }
}


