//
//  ExtensionUIImageView.swift
//  BDS
//
//  Created by Duy Huy on 11/29/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
extension UIImageView {
    
    func setImageUrl(url:String!){
        if url == nil || url == "" {
            self.image = UIImage(named: IMAGE_HOLDER)
            return
        }
        if url.contains("http") {
            self.setImageUrlChat(url: url)
            return
        }else {
            self.kf.setImage(with: URL(string: url), placeholder: UIImage(named: IMAGE_HOLDER))
        }
    }
    func setImageUrlChat(url:String!){
        if url != nil && url != "" {
            self.kf.setImage(with: URL(string: url), placeholder: UIImage(named: IMAGE_HOLDER))
        } else {
            self.image = UIImage(named: IMAGE_HOLDER)
        }
    }
    
    func setImageUrlNews(url:String!){
        if url != nil && url != "" {
            self.kf.setImage(with: URL(string: url), placeholder: UIImage(named: "icon_plachoder_chat"))
        } else {
            self.image = UIImage(named: "icon_plachoder_chat")
        }
    }
    
    func setImageProject(url:URL!){
        if url != nil  {
            self.kf.setImage(with: url, placeholder: UIImage(named: "icon_plachoder_chat"))
        } else {
            self.image = UIImage(named: "icon_plachoder_chat")
        }
    }
    func addBlurEffect()
    {
        var blurEffect: UIBlurEffect!
        if #available(iOS 10.0, *) {
            blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        } else {
            blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        }
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
}

extension UIImage {
    
    func resizeImage(newWidth: CGFloat) -> UIImage {
        
        if self.size.width < newWidth && self.size.height < newWidth {
            return self
        }
        
        if self.size.width > self.size.height {
            
            let scale = newWidth / self.size.width
            let newHeight = self.size.height * scale
            UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
            self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage!
        } else {
            
            let scale = newWidth / self.size.height
            let newW = self.size.width * scale
            UIGraphicsBeginImageContext(CGSize(width: newW, height: newWidth))
            self.draw(in: CGRect(x: 0, y: 0, width: newW, height: newWidth))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage!
        }
    }
    
    var isPortrait: Bool { return size.height > size.width }
    var isLandscape: Bool { return size.width > size.height }
    var breadth: CGFloat { return min(size.width, size.height) }
    var breadthSize: CGSize { return CGSize(width: breadth, height: breadth) }
    var breadthRect: CGRect { return CGRect(origin: .zero, size: breadthSize) }
    var circleMasked: UIImage? {
        UIGraphicsBeginImageContextWithOptions(breadthSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let cgImage = cgImage?.cropping(to: CGRect(origin: CGPoint(x: isLandscape ? floor((size.width - size.height) / 2) : 0, y: isPortrait ? floor((size.height - size.width) / 2) : 0), size: breadthSize)) else { return nil }
        UIBezierPath(ovalIn: breadthRect).addClip()
        UIImage(cgImage: cgImage).draw(in: breadthRect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}


