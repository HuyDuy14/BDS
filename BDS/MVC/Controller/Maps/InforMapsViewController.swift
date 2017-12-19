//
//  InforMapsViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/1/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol InforMapsViewControllerDelegate:class
{
    func disLoadDataMaps(_ controller:InforMapsViewController,listData:[LandSaleModel])
}

class InforMapsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var numberNews: UILabel!
    @IBOutlet var topSeparatorView: UIView!
    @IBOutlet var headerSectionHeightConstraint: NSLayoutConstraint!
    
    weak var delegate:InforMapsViewControllerDelegate?
    var listData:[LandSaleModel] = []
    let fullView: CGFloat = 90
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - 90
    }
    let disposeBag = DisposeBag()
    var type:String = "sale"
    var r = "2"
    var lat = "null"
    var lng = "null"
    
    fileprivate var drawerBottomSafeArea: CGFloat = 0.0 {
        didSet {
            self.loadViewIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(InforMapsViewController.panGesture))
        gesture.delegate = self
        view.addGestureRecognizer(gesture)
        self.loadData()
        self.roundViews()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBackgroundView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            let frame = self?.view.frame
            let yComponent = self?.partialView
            self?.view.frame = CGRect(x: 0, y: yComponent!, width: frame!.width, height: frame!.height)
        })
//        self.animationShow()
    }
    
    func roundViews() {
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
    }
    
    func animationShow()
    {
        let frame = self.view.frame
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            self?.view.frame = CGRect(x: 0, y: (self?.view.frame.height)! - 250, width: frame.width, height: (self?.view.frame.height)!)
        })
    }
    
    func panGesture(_ recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        let velocity = recognizer.velocity(in: self.view)
        
        let y = self.view.frame.minY
        if (y + translation.y >= fullView) && (y + translation.y <= partialView) {
            self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        
        if recognizer.state == .ended {
            var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
            
            duration = duration > 1.3 ? 1 : duration
            
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                if  velocity.y >= 0 {
                    self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
                } else {
                    self.view.frame = CGRect(x: 0, y: self.view.frame.height - 400, width: self.view.frame.width, height: self.view.frame.height)
                }
                
            }, completion: { [weak self] _ in
                if ( velocity.y < 0 ) {
                    self?.tableView.isScrollEnabled = true
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
    
    //MARK : -LoadData
    func loadData()
    {
        self.listData = []
        self.showHUD("")
        APIClient.shared.getDataShowMaps(type: self.type, lat: self.lat, lng: self.lng, r: self.r).asObservable().bind(onNext: { result in
            DispatchQueue.main.async {
                var projects: [LandSaleModel] = []
                for data in result.dataArray
                {
                    if let dic = data as? [String:Any]
                    {
                        let project = LandSaleModel(JSON: dic)
                        projects.append(project!)
                    }
                }
                self.listData.append(contentsOf: projects)
                self.delegate?.disLoadDataMaps(self, listData:  self.listData)
                self.tableView.reloadData()
                self.hideHUD()
            }
        }).disposed(by: self.disposeBag)
    }
}

extension InforMapsViewController: UIGestureRecognizerDelegate {
    
    // Solution
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        let gesture = (gestureRecognizer as! UIPanGestureRecognizer)
        let direction = gesture.velocity(in: view).y
        
        let y = view.frame.minY
        if (y == fullView && self.tableView.contentOffset.y == 0 && direction > 0) || (y == partialView) {
            self.tableView.isScrollEnabled = false
        } else {
            self.tableView.isScrollEnabled = true
        }
        
        return false
    }
    
}

extension InforMapsViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < self.listData.count {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "MapsViewCell") as! MapsViewCell
            cell.loadDataCell(cell: self.listData[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < self.listData.count {
            let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
            let showDetail = storyboard.instantiateViewController(withIdentifier: "DetailLanforSaleViewController") as? DetailLanforSaleViewController
            showDetail?.landForSale = self.listData[indexPath.row]
            
            self.pushViewController(viewController: showDetail)
        }
        
    }
}

