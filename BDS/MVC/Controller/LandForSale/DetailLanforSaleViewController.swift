//
//  DetailLanforSaleViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/7/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class DetailLanforSaleViewController: BaseViewController {

    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var nameContact: UILabel!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var dateEnd: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var dateBegin: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var idLand: UILabel!
    @IBOutlet weak var address: UILabel!
    
    var landForSale:LandSaleModel!
    override func viewDidLoad() {
        super.viewDidLoad()

      self.fillData()
    }
    
    func fillData()
    {
        self.nameContact.text = self.landForSale.poster_name
        self.phone.text = self.landForSale.poster_phone
        self.area.text = self.landForSale.land_area + "m2"
        self.price.text = self.landForSale.land_price + " tỷ/m2"
        self.address.text = self.landForSale.district_name + " , " + self.landForSale.city_name
        self.dateBegin.text = self.landForSale.land_date_start.FromStringToDateToStringProjects()
        self.dateEnd.text = self.landForSale.land_date_finish.FromStringToDateToStringProjects()
        self.type.text = self.landForSale.category_name
        self.idLand.text = self.landForSale.code
         self.webView.loadHTMLString(Util.shared.htmlString(from: self.landForSale.content), baseURL: nil)
    }
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.popToView()
    }
    @IBAction func mapButtonDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Projects", bundle: nil)
        let showDetail = storyboard.instantiateViewController(withIdentifier: "DetailMapsViewController") as? DetailMapsViewController
        showDetail?.landForSale = self.landForSale
        self.pushViewController(viewController: showDetail)
    }
    
}
