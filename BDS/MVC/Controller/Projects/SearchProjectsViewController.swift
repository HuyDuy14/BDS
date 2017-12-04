//
//  SearchProjectsViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/1/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchProjectsViewController: BaseViewController {

    @IBOutlet weak var district: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var typeLand: UILabel!
    @IBOutlet weak var monney: UILabel!
    @IBOutlet weak var headerView: HeaderViewController!
    
    let disposeBag = DisposeBag()
    var pickerView = PickerView.getFromNib()
    var listPicker:[ModelPicker] = [ModelPicker(id: 0, name: "Hà Nội"),ModelPicker(id: 2, name: "Thanh Hoá"),ModelPicker(id: 3, name: "Nam Định")]
    var listPickerCity:[ModelPicker] = []
    var listPickerDistrict:[ModelPicker] = []
    var listPickerTypeProject:[ModelPicker] = []
  
    var idProject:Int = 0
    var idCity:Int = 0
    var indexSelectCity:Int = 0
    var idDictrict:Int = 0
    var indexSelectDistrict:Int = 0
    var indextSelectProject:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.delegate = self
        self.headerView.setTitleView(title: "Tìm môi giới", infor: "Tìm môi giới hổ trợ tư vấn BĐS")
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
        for type in Util.shared.typesProject {
            let picker = ModelPicker(id: Int(type.id)!, name: type.name)
            picker.index = index
            index += 1
            self.listPickerTypeProject.append( picker)
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
        if self.idCity != 0 {
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
    
    @IBAction func selectMonneyButtonDidTap(_ sender: Any) {
        self.pickerView.listData = self.listPicker
        self.pickerView.config.startIndex = 2
        self.pickerView.show(inVC: self)
        
    }
    
    @IBAction func searchButtonDidTap(_ sender: Any) {
        
        if self.idCity == 0 && self.idProject == 0 && self.idDictrict == 0
        {
            self.showAlert("Bạn phải chọn ít nhất một yều cầu tìm kiếm")
            return
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailSearch = storyboard.instantiateViewController(withIdentifier: "ProjectsViewController") as? ProjectsViewController
        detailSearch?.idDictrict = self.idDictrict
        detailSearch?.idCity = self.idCity
        detailSearch?.idProject = self.idProject
        detailSearch?.isBackHome = false
        self.pushViewController(viewController: detailSearch!)
      
    }
}

extension SearchProjectsViewController:PickerViewDelegate
{
    func miPickerViewDidCancelSelection(_ amPicker: PickerView) {
        
    }
    
    func miPickerView(_ amPicker: PickerView, didSelect picker: ModelPicker) {
        switch amPicker.status
        {
        case 0:
            self.city.text = picker.name
            self.idCity = picker.id
            self.indexSelectCity = picker.index
            self.showHUD("")
            self.district.text = "Chọn quận/Huyện"
            self.idDictrict = 0
            self.indexSelectDistrict = 0
            self.loadDistrict(idCity: String(picker.id))
            break
        case 1:
            self.district.text = picker.name
            self.idDictrict = picker.id
            self.indexSelectDistrict = picker.index
        case 3:
            self.typeLand.text = picker.name
            self.idProject = picker.id
            self.indextSelectProject = picker.index
        default:
            break
        }
    }
}

