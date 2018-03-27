//
//  InforMapsProjectViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/6/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
protocol  InforMapsProjectViewControllerDelegate:class
{
    func showHidePopOver(_ controller:InforMapsProjectViewController)
     func showFullInfor(_ controller:InforMapsProjectViewController)
}

class InforMapsProjectViewController: BaseViewController {

    @IBOutlet weak var titlelProject: UILabel!
    @IBOutlet weak var idProject: UILabel!
    
    @IBOutlet weak var addAre: UILabel!
    @IBOutlet weak var dateEnd: UILabel!
    @IBOutlet weak var priceProject: UILabel!
    @IBOutlet weak var dateCreate: UILabel!
    @IBOutlet weak var typeProject: UILabel!
    @IBOutlet weak var addRess: UILabel!
    var type = "sale"
    var listTypePrice:[ModelPicker] = [ModelPicker(id: 0, name: "Thoả thuận"),ModelPicker(id: 1, name: "Triệu"),ModelPicker(id: 2, name: "Tỷ"),ModelPicker(id: 6, name: "Trăm nghìn/m2"),ModelPicker(id: 7, name: "Triệu/m2")]
    var listTypePriceRent:[ModelPicker] = [ModelPicker(id: 0, name: "Thoả thuận"),ModelPicker(id: 1, name: "Trăm nghìn/tháng"),ModelPicker(id: 2, name: "Triệu/tháng"),ModelPicker(id: 3, name: "Trăm nghìn/m2/Tháng"),ModelPicker(id: 3, name: " Triệu/m2/Tháng"),ModelPicker(id: 5, name: " Nghìn/m2/Tháng")]
    let fullView: CGFloat = 50
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - 50
    }
    var project:ProjectsModel!
    var landForSale:LandSaleModel!
    weak var delegate:InforMapsProjectViewControllerDelegate?
    
    fileprivate var drawerBottomSafeArea: CGFloat = 0.0 {
        didSet {
            self.loadViewIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.roundViews()
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(InforMapsViewController.panGesture))
        gesture.delegate = self
        view.addGestureRecognizer(gesture)
        self.fillData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBackgroundView()
    }
    
    func fillData()
    {
        if self.project != nil
        {
            self.titlelProject.text = project.title
            self.addRess.text = project.address
            self.dateCreate.text = project.date_start.FromStringToDateToString()
            self.dateEnd.text = project.date_finish.FromStringToDateToString()
            self.addAre.text = project.land_area
            self.priceProject.text = project.price
            self.idProject.text = "BDS" + project.id
            self.typeProject.text = ""
            if  self.landForSale.land_price_type == "0"
            {
                self.priceProject.text = "Thoả thuận"
                return
            }
            for item in self.listTypePrice
            {
                
                if String(item.id) ==  self.landForSale.land_price_type
                {
                    self.priceProject.text = self.project.price + " " + item.name
                    return
                }
            }
        }
        else
        {
            if self.landForSale == nil
            {
                return
            }
            self.titlelProject.text = self.landForSale.title
            self.addAre.text = self.landForSale.land_area + "m2"
            self.priceProject.text = self.landForSale.land_price
            self.addRess.text = self.landForSale.district_name + " , " + self.landForSale.city_name
            self.dateCreate.text = self.landForSale.land_date_start.FromStringToDateToStringProjects()
            self.dateEnd.text = self.landForSale.land_date_finish.FromStringToDateToStringProjects()
            self.typeProject.text = self.landForSale.category_name
            self.idProject.text = self.landForSale.code
            if  self.landForSale.land_price_type == "0"
            {
                self.priceProject.text = "Thoả thuận"
                return
            }
            if self.landForSale.type == "sale"
            {
                for item in self.listTypePrice
                {
                    
                    if String(item.id) ==  self.landForSale.land_price_type
                    {
                        self.priceProject.text = self.landForSale.land_price + " " + item.name
                        return
                    }
                }
            }
            else
            {
                for item in self.listTypePriceRent
                {
                    if String(item.id) ==  self.landForSale.land_price_type
                    {
                        self.priceProject.text = self.landForSale.land_price + " " + item.name
                        return
                    }
                }
            }
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            let frame = self?.view.frame
            let yComponent = self?.partialView
            self?.view.frame = CGRect(x: 0, y:  yComponent!, width: frame!.width, height:UIScreen.main.bounds.height)
        })
        
    }
    
    func animationShowView()
    {
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            let frame = self?.view.frame
            //            let yComponent = self?.partialView
            self?.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height / 2.5 , width: frame!.width, height: (frame?.height)! - 50)
        })
    }
    
    func animationHideView()
    {
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            self?.view.frame = CGRect(x: 0, y: (self?.partialView)!, width: (self?.view.frame.width)!, height: (self?.view.frame.height)!)
        })
    }
    
    func roundViews() {
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
    }
    
    func panGesture(_ recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        let velocity = recognizer.velocity(in: self.view)
        
        let y = self.view.frame.minY
        if (y + translation.y >= fullView) && (y + translation.y <= partialView) {
            if velocity.y >= 0
            {
                self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
                recognizer.setTranslation(CGPoint.zero, in: self.view)
            }
//            else
//            {
//                if (view.frame.height - 300 ) <= y + translation.y{
//                    self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
//                    recognizer.setTranslation(CGPoint.zero, in: self.view)
//                }
//            }
        }
        
        if recognizer.state == .ended {
            var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
            
            duration = duration > 1.3 ? 1 : duration
            
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                if  velocity.y >= 0 {
                    self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
                    self.delegate?.showHidePopOver(self)
                }
                
            }, completion: {  _ in
                if ( velocity.y < 0 ) {
                 
                }
            })
        }
    }
    
    
    func prepareBackgroundView(){
        let blurEffect = UIBlurEffect.init(style: .dark)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)
        visualEffect.frame = UIScreen.main.bounds
        bluredView.frame = UIScreen.main.bounds
        view.insertSubview(bluredView, at: 0)
    }
    
    @IBAction func showFullInforDidTap(_ sender: Any) {
        self.delegate?.showFullInfor(self)
    }
    
}

extension InforMapsProjectViewController: UIGestureRecognizerDelegate {
    
    // Solution
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
      
        return false
    }
    
}
