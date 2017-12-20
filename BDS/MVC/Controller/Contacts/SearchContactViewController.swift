//
//  SearchContactViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/1/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchContactViewController: BaseViewController {
    @IBOutlet weak var headerView: HeaderViewController!
    @IBOutlet weak var district: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var typeLand: UILabel!
    @IBOutlet weak var typeBDS: UILabel!
    
    var pickerView = PickerView.getFromNib()
    var listPicker:[ModelPicker] = [ModelPicker(id: 0, name: "Hà Nội"),ModelPicker(id: 2, name: "Thanh Hoá"),ModelPicker(id: 3, name: "Nam Định")]
     var listTypeLand:[ModelPicker] = [ModelPicker(id: 1, name: "Nhà đất cho thuê"),ModelPicker(id: 2, name: "Nhà đất bán")]
    var listPickerCity:[ModelPicker] = []
    var listPickerDistrict:[ModelPicker] = []
    var listPickerTypeProject:[ModelPicker] = []
    let disposeBag = DisposeBag()
    
    var idProject:String = "null"
    var idCity:String = "null"
    var indexSelectCity:Int = 0
    var idDictrict:String = "null"
    var indexSelectDistrict:Int = 0
    var indextSelectProject:Int = 0
    var type = "1"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.delegate = self
        self.headerView.setTitleView(title: "Tìm môi giới", infor: "Tìm môi giới hỗ trợ tư vấn BĐS")
        self.pickerView.delegate = self
        var index:Int = 0
        for city in Util.shared.listCity {
            let picker = ModelPicker(id: Int(city.id)!, name: city.name)
            picker.index = index
            index += 1
            self.listPickerCity.append( picker)
        }
        self.setDataPicker()
        
    }
    
    func setDataPicker()
    {
        var index:Int = 0
        if type == "1"
        {
            self.listPickerTypeProject = []
            for type in Util.shared.listCategorySale {
                let picker = ModelPicker(id: Int(type.id)!, name: type.name)
                picker.index = index
                index += 1
                self.listPickerTypeProject.append( picker)
            }
        }
        else
        {
            self.listPickerTypeProject = []
            for type in Util.shared.listCategoryRent {
                let picker = ModelPicker(id: Int(type.id)!, name: type.name)
                picker.index = index
                index += 1
                self.listPickerTypeProject.append( picker)
            }
        }
       
    }
    
    func loadDataCity()
    {
        Util.shared.listCity = []
        self.listPickerCity = []
        APIClient.shared.getCity().asObservable().bind(onNext: { result in
            for data in result.dataArray
            {
                if let dic = data as? [String:Any]
                {
                    let city = ModelCity(JSON: dic)
                    Util.shared.listCity.append(city!)
                }
            }
            var index:Int = 0
            for city in Util.shared.listCity {
                let picker = ModelPicker(id: Int(city.id)!, name: city.name)
                picker.index = index
                index += 1
                self.listPickerCity.append(picker)
            }
            
            
        }).disposed(by: self.disposeBag)
    }
    
    func loadDistrict(idCity:String)
    {
        self.listPickerDistrict = []
        var listDictrict:[DistrictModel] = []
        APIClient.shared.getDistrict(id: idCity).asObservable().bind(onNext: { result in
            for data in result.dataArray
            {
                if let dic = data as? [String:Any]
                {
                    let city = DistrictModel(JSON: dic)
                    listDictrict.append(city!)
                }
            }
            var index:Int = 0
            for city in listDictrict {
                let picker = ModelPicker(id: Int(city.id)!, name: city.name)
                picker.index = index
                index += 1
                self.listPickerDistrict.append(picker)
            }
            self.hideHUD()
        }).disposed(by: self.disposeBag)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectTypeButtonDidTap(_ sender: Any) {
        self.pickerView.listData = self.listPickerTypeProject
        self.pickerView.config.startIndex = self.indextSelectProject
        self.pickerView.status  = 3
        self.pickerView.show(inVC: self)
    }
    
    @IBAction func selectCityButtonDidTap(_ sender: Any) {
        self.pickerView.listData = self.listPickerCity
        self.pickerView.config.startIndex = self.indexSelectCity
        self.pickerView.status = 0
        self.pickerView.show(inVC: self)
        
    }
    
    @IBAction func selectDistrictButtonDidTap(_ sender: Any) {
        if self.idCity != "null" {
            self.pickerView.listData = self.listPickerDistrict
            self.pickerView.config.startIndex = self.indexSelectDistrict
            self.pickerView.status = 1
            self.pickerView.show(inVC: self)
        }
        else
        {
            self.showAlert("Bạn chưa chọn tỉnh thành")
        }
    }
    
    @IBAction func searchButtonDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
        let detailSearch = storyboard.instantiateViewController(withIdentifier: "ContactsViewController") as? ContactsViewController
        detailSearch?.idProject = self.idProject
        detailSearch?.idCity = self.idCity
        detailSearch?.idDistrict = self.idDictrict
        detailSearch?.idType = self.type
        self.pushViewController(viewController: detailSearch!)
    }
    
    @IBAction func selectypeBDSButtonDidTap(_ sender: Any) {
        self.pickerView.listData = self.listTypeLand
        self.pickerView.config.startIndex = 0
        self.pickerView.status = 2
        self.pickerView.show(inVC: self)
    }
    
    
}

extension SearchContactViewController:PickerViewDelegate
{
    func selectPickerView(_ Ppicker: PickerView, didSelect picker: ModelPicker, index: Int) {
        
    }
    
    func miPickerViewDidCancelSelection(_ amPicker: PickerView) {
        
    }
    
    func miPickerView(_ amPicker: PickerView, didSelect picker: ModelPicker) {
        switch amPicker.status
        {
        case 0:
            self.city.text = picker.name
            self.idCity = String(picker.id)
            self.indexSelectCity = picker.index
            self.showHUD("")
            self.district.text = "Chọn quận/Huyện"
            self.idDictrict = "null"
            self.indexSelectDistrict = 0
            self.loadDistrict(idCity: String(picker.id))
            break
        case 2:
            self.typeBDS.text = picker.name
            if picker.id == 1
            {
                self.type = "2"
                
            }
            else
            {
                self.type = "1"
            }
            self.typeLand.text = "Chọn loại nhà đất"
            self.idProject = "null"
            self.indextSelectProject = 0
            self.setDataPicker()
        case 1:
            self.district.text = picker.name
            self.idDictrict = String(picker.id)
            self.indexSelectDistrict = picker.index
        case 3:
            self.typeLand.text = picker.name
            self.idProject = String(picker.id)
            self.indextSelectProject = picker.index
        default:
            break
        }
    }
}
