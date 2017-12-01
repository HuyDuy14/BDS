//
//  SearchContactViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/1/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class SearchContactViewController: BaseViewController {
    @IBOutlet weak var headerView: HeaderViewController!
    
    var pickerView = PickerView.getFromNib()
    var listPicker:[ModelPicker] = [ModelPicker(id: 0, name: "Hà Nội"),ModelPicker(id: 2, name: "Thanh Hoá"),ModelPicker(id: 3, name: "Nam Định")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.delegate = self
        self.headerView.setTitleView(title: "Tìm môi giới", infor: "Tìm môi giới hổ trợ tư vấn BĐS")
        self.pickerView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectTypeButtonDidTap(_ sender: Any) {
        self.pickerView.listData = self.listPicker
        self.pickerView.index = 0
        self.pickerView.show(inVC: self)
    }
    
    @IBAction func selectCityButtonDidTap(_ sender: Any) {
        self.pickerView.listData = self.listPicker
        self.pickerView.index = 0
        self.pickerView.show(inVC: self)
        
    }
    
    @IBAction func selectDistrictButtonDidTap(_ sender: Any) {
        self.pickerView.listData = self.listPicker
        self.pickerView.index = 0
        self.pickerView.show(inVC: self)
    }
    
    @IBAction func searchButtonDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
        let detailSearch = storyboard.instantiateViewController(withIdentifier: "ContactsViewController") as? ContactsViewController
        self.pushViewController(viewController: detailSearch!)
    }
    
}

extension SearchContactViewController:PickerViewDelegate
{
    func miPickerViewDidCancelSelection(_ amPicker: PickerView) {
        
    }
    
    func miPickerView(_ amPicker: PickerView, didSelect picker: ModelPicker) {
        
    }
}
