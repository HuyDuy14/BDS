//
//  PickerView.swift
//  PLA
//
//  Created by Huy Duy on 6/8/17.
//  Copyright © 2017 HuyDuy. All rights reserved.
//

import UIKit

protocol PickerViewDelegate: class {
    
    func miPickerView(_ amPicker: PickerView, didSelect picker: ModelPicker)
    func miPickerViewDidCancelSelection(_ amPicker: PickerView)
    
}

class PickerView: UIView,UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - Config
    struct Config {
        
        fileprivate let contentHeight: CGFloat = 240
        fileprivate let bouncingOffset: CGFloat = 20
        var startIndex:Int = 0
        
        var confirmButtonTitle = "Done"
        var cancelButtonTitle = "Cancel"
        
        var headerHeight: CGFloat = 50
        
        var animationDuration: TimeInterval = 0.3
        
        var overlayBackgroundColor: UIColor = UIColor.black.withAlphaComponent(0.6)
        
    }
    
    var config = Config()
    
    weak var delegate: PickerViewDelegate?
    
    // MARK: - IBOutlets
 
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    var checkEdit:Bool = false
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    var index:Int = 0
    var bottomConstraint: NSLayoutConstraint!
    var overlayButton: UIButton!
    var listData:[ModelPicker] = []
    var listDataColor:[UIColor] = []
    var storeName:Bool = false
    var typeJob: Bool = false
    var department:Bool = false
    var positon:Bool = false
    var status: Int = 0

    // MARK: - Init
    static func getFromNib() -> PickerView {
        return UINib.init(nibName: String(describing: self), bundle: nil).instantiate(withOwner: self, options: nil).last as! PickerView
    }
    
    // MARK: - IBAction
    @IBAction func confirmButtonDidTapped(_ sender: AnyObject) {
        dismiss()
        if self.index < self.listData.count {
            delegate?.miPickerView(self, didSelect: self.listData[self.index])
        }
        
    }
    @IBAction func cancelButtonDidTapped(_ sender: AnyObject) {
        dismiss()
        delegate?.miPickerViewDidCancelSelection(self)
    }
    
    // MARK: - Private
    fileprivate func setup(_ parentVC: UIViewController) {
        
        // Loading configuration
        
   
        headerViewHeightConstraint.constant = config.headerHeight
        
        confirmButton.setTitle(config.confirmButtonTitle, for: UIControlState())
        cancelButton.setTitle(config.cancelButtonTitle, for: UIControlState())
        
        // Overlay view constraints setup
        
        overlayButton = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        overlayButton.backgroundColor = config.overlayBackgroundColor
        overlayButton.alpha = 0
        
        overlayButton.addTarget(self, action: #selector(cancelButtonDidTapped(_:)), for: .touchUpInside)
        
        if !overlayButton.isDescendant(of: parentVC.view) { parentVC.view.addSubview(overlayButton) }
        
        overlayButton.translatesAutoresizingMaskIntoConstraints = false
        
        parentVC.view.addConstraints([
            NSLayoutConstraint(item: overlayButton, attribute: .bottom, relatedBy: .equal, toItem: parentVC.view, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: overlayButton, attribute: .top, relatedBy: .equal, toItem: parentVC.view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: overlayButton, attribute: .leading, relatedBy: .equal, toItem: parentVC.view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: overlayButton, attribute: .trailing, relatedBy: .equal, toItem: parentVC.view, attribute: .trailing, multiplier: 1, constant: 0)
            ]
        )
        
        // Setup picker constraints
        
        frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: config.contentHeight + config.headerHeight)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: parentVC.view, attribute: .bottom, multiplier: 1, constant: 0)
        
        if !isDescendant(of: parentVC.view) { parentVC.view.addSubview(self) }
        
        parentVC.view.addConstraints([
            bottomConstraint,
            NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: parentVC.view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: parentVC.view, attribute: .trailing, multiplier: 1, constant: 0)
            ]
        )
        addConstraint(
            NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: frame.height)
        )
        
        move(goUp: false)
        
    }
    fileprivate func move(goUp: Bool) {
        bottomConstraint.constant = goUp ? config.bouncingOffset : config.contentHeight + config.headerHeight
    }
    
    // MARK: - Public
    func show(inVC parentVC: UIViewController, completion: (() -> ())? = nil) {
        
        parentVC.view.endEditing(true)
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
//        self.pickerView.
        setup(parentVC)
        move(goUp: true)
        
        UIView.animate(
            withDuration: config.animationDuration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5, options: .curveEaseIn, animations: {
                
                parentVC.view.layoutIfNeeded()
                self.overlayButton.alpha = 1
                
        }, completion: { (finished) in
            completion?()
        }
        )
        
    }
    func dismiss(_ completion: (() -> ())? = nil) {
        
        move(goUp: false)
        
        UIView.animate(
            withDuration: config.animationDuration, animations: {
                
                self.layoutIfNeeded()
                self.overlayButton.alpha = 0
                
        }, completion: { (finished) in
            completion?()
            self.removeFromSuperview()
            self.overlayButton.removeFromSuperview()
        }
        )
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.listData.count
    }
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        let name:String = self.listData[row].name
//      
//        if self.listDataColor.count > 0 {
//            let color:UIColor =  self.listDataColor[row]
//            let attributedString = NSAttributedString(string: name, attributes: [NSForegroundColorAttributeName : color])
//            return attributedString
//        }
//        return NSAttributedString(string: name, attributes: [NSForegroundColorAttributeName : UIColor.darkGray])
//    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
     
        return self.listData[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        delegate?.miPickerView(self, didSelect: self.listData[row])
        self.index = row
    }
}
