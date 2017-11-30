//
//  GetViewXib.swift
//  BDS
//
//  Created by Duy Huy on 11/30/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

func getXibViewController<T: UIViewController>(_ viewControllerClassName: T.Type) -> T? {
    let name = String(describing: T.self)
    if Bundle.main.path(forResource: name, ofType: "nib") != nil || Bundle.main.path(forResource: name, ofType: "xib") != nil {
        return T(nibName: name, bundle: nil)
    }
    return nil
}

func nibFromClass<T: NSObject>(_ className: T.Type) -> UINib? {
    let name = String(describing: T.self)
    if Bundle.main.path(forResource: name, ofType: "nib") != nil || Bundle.main.path(forResource: name, ofType: "xib") != nil {
        return UINib(nibName: String(describing: T.self), bundle: nil)
    }
    return nil
}

func nameOfClass<T: NSObject>(_ type: T.Type) -> String {
    return String(describing: T.self)
}

