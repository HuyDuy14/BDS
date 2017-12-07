//
//  InforMapsProjectViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/6/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class InforMapsProjectViewController: BaseViewController {

    @IBOutlet weak var titlelProject: UILabel!
    @IBOutlet weak var idProject: UILabel!
    
    @IBOutlet weak var addAre: UILabel!
    @IBOutlet weak var dateEnd: UILabel!
    @IBOutlet weak var priceProject: UILabel!
    @IBOutlet weak var dateCreate: UILabel!
    @IBOutlet weak var typeProject: UILabel!
    @IBOutlet weak var addRess: UILabel!
    
    let fullView: CGFloat = 50
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - 50
    }
    var project:ProjectsModel!
    var landForSale:LandSaleModel!
    
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
            self.priceProject.text = project.price + "/m2"
            self.idProject.text = "BDS" + project.id
            self.typeProject.text = ""
        }
        else
        {
          
            self.titlelProject.text = self.landForSale.title
            self.addAre.text = self.landForSale.land_area + "m2"
            self.priceProject.text = self.landForSale.land_price + " tỷ/m2"
            self.addRess.text = self.landForSale.district_name + " , " + self.landForSale.city_name
            self.dateCreate.text = self.landForSale.land_date_start.FromStringToDateToStringProjects()
            self.dateEnd.text = self.landForSale.land_date_finish.FromStringToDateToStringProjects()
            self.typeProject.text = self.landForSale.category_name
            self.idProject.text = self.landForSale.code
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            let frame = self?.view.frame
//            let yComponent = self?.partialView
            self?.view.frame = CGRect(x: 0, y: (frame?.height)! - 400 , width: frame!.width, height: (frame?.height)! - 50)
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
            else
            {
                if (view.frame.height - 300 ) <= y + translation.y{
                    self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
                    recognizer.setTranslation(CGPoint.zero, in: self.view)
                }
            }
        }
        
        if recognizer.state == .ended {
            var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
            
            duration = duration > 1.3 ? 1 : duration
            
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                if  velocity.y >= 0 {
                    self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
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
}

extension InforMapsProjectViewController: UIGestureRecognizerDelegate {
    
    // Solution
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
      
        return false
    }
    
}
