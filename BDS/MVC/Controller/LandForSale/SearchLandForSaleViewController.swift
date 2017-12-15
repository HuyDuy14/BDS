//
//  SearchLandForSaleViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/1/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol SearchLandForSaleViewControllerDelegate:class
{
    func searchLand(_ controlelr:SearchLandForSaleViewController,_ project_id: String,_ title: String,_ type: String,_ city: String,_ ward: String,_ area_min: String,_ area_max: String,_ price_min: String,_ price_max: String,_ district: String,_ numberbedroom: String, _ direction: String)
}

class SearchLandForSaleViewController: BaseViewController {

    @IBOutlet weak var imageMore: UIImageView!
    @IBOutlet weak var headerView: HeaderViewController!
    
    @IBOutlet weak var titleSearch: UITextField!
    @IBOutlet weak var areLabel: UILabel!
    @IBOutlet weak var priceBDS: UILabel!
    @IBOutlet weak var nameDistrict: UILabel!
    @IBOutlet weak var nameCity: UILabel!
    @IBOutlet weak var typeBDS: UILabel!
    @IBOutlet weak var wards: UILabel!
    @IBOutlet weak var nameHome: UILabel!
    @IBOutlet weak var bedroom: UILabel!
   
    // MARK :- heightView
    @IBOutlet weak var heightViewHome: NSLayoutConstraint!
    @IBOutlet weak var heightWards: NSLayoutConstraint!
    @IBOutlet weak var heightBedroom: NSLayoutConstraint!
    @IBOutlet weak var heightView: NSLayoutConstraint!
    
    var isSearchRent:Bool = true
    var isShow:Bool = false
    let disposeBag = DisposeBag()
    var pickerView = PickerView.getFromNib()
    weak var delegate:SearchLandForSaleViewControllerDelegate?
    
    var listPickerCity:[ModelPicker] = []
    var listPickerDistrict:[ModelPicker] = []
    var listPickerTypeProject:[ModelPicker] = []
    
    var listPicker:[ModelPicker] = [ModelPicker(id: 1, name: "Dưới 300 Triệu"),ModelPicker(id: 2, name: "300 Triệu - 500 Triệu"),ModelPicker(id: 3, name: "700 Triệu - 1 Tỷ"),ModelPicker(id: 4, name: "1 Tỷ - 2 Tỷ"),ModelPicker(id: 5, name: "2 Tỷ - 3 Tỷ"),ModelPicker(id: 6, name: "3 Tỷ - 5 Tỷ"),ModelPicker(id: 7, name: "5 Tỷ - 7 Tỷ"),ModelPicker(id: 8, name: "7 Tỷ - 10 Tỷ"),ModelPicker(id: 9, name: "10 Tỷ - 20 Tỷ"),ModelPicker(id: 10, name: "20 Tỷ - 30 Tỷ"),ModelPicker(id: 11, name: "Trên 30 Tỷ")]
    var listPickerRent:[ModelPicker] = [ModelPicker(id: 1, name: "Dưới 3 Triệu"),ModelPicker(id: 2, name: "3 Triệu - 5 Triệu"),ModelPicker(id: 3, name: "5 Triệu - 7 Triệu"),ModelPicker(id: 4, name: "7 Triệu - 10 Triệu"),ModelPicker(id: 5, name: "10 Triệu - 20 Triệu"),ModelPicker(id: 6, name: "20 Triệu - 30 Triệu"),ModelPicker(id: 7, name: "Trên 30 Triệu")]
    
    var listDirection:[ModelPicker] =  [ModelPicker(id: 1, name: "Đông"),ModelPicker(id: 2, name: "Tây"),ModelPicker(id: 3, name: "Nam"),ModelPicker(id: 4, name: "Bắc"),ModelPicker(id: 5, name: "Đông-Bắc"),ModelPicker(id: 6, name: "Tây-Bắc"),ModelPicker(id: 7, name: "Đông-Nam"),ModelPicker(id: 8, name: "Tây-Nam")]
    var listAcreage:[ModelPicker] = [ModelPicker(id: 1, name: "Dưới 30m2"),ModelPicker(id: 2, name: "30m2 - 50m2"),ModelPicker(id: 3, name: "50m2 - 100m2"),ModelPicker(id: 4, name: "100m2 - 150m2"),ModelPicker(id: 5, name: "150m2 - 200m2"),ModelPicker(id: 6, name: "200m2 - 300m2"),ModelPicker(id: 7, name: "300m2 - 500m2"),ModelPicker(id: 8, name: "500m2 - 700m2"),ModelPicker(id: 9, name: "700m2 - 1000m2"),ModelPicker(id: 10, name: "Trên 1000m2")]
    
    var listNumberBedRoom:[ModelPicker] =  [ModelPicker(id: 1, name: "1"),ModelPicker(id: 2, name: "2"),ModelPicker(id: 3, name: "3"),ModelPicker(id: 4, name: "4"),ModelPicker(id: 5, name: "5"),ModelPicker(id: 6, name: "6"),ModelPicker(id: 7, name: "7"),ModelPicker(id: 8, name: "8"),ModelPicker(id: 9, name: "9"),ModelPicker(id: 10, name: "10")]
    var listWard:[ModelPicker] = []
    
    // MARK: ListData Push
    
    var idProject:String = "null"
    var idDistrict:String = "null"
    var idCity = "null"
    var idWards:String = "null"
    var idDirection = "null"
    var idAcreage = "null"
    var idBedRoom = "null"
    var titles = "null"
    var idBedroom = "null"
    var price_max = "null"
    var pricae_min = "null"
    var are_min = "null"
    var are_max = "null"
    var type = "null"
    
    // MARK: Index Select
    var indexTypeProject:Int = 0
    var indexDistrict:Int = 0
    var indexCity:Int = 0
    var indexBedroom :Int = 0
    var indexPrice:Int = 0
    var indeDirection = 0
    var indexWard = 0
    var indexAcreage = 0
    var isRale:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.delegate = self
        if isRale == true
        {
            self.headerView.setTitleView(title: "Tìm kiếm nhà đất bán", infor: "Tìm kiếm nâng cao")
        }
        else
        {
             self.headerView.setTitleView(title: "Tìm kiếm nhà đất thuê", infor: "Tìm kiếm nâng cao")
        }
        self.pickerView.delegate = self
        self.imageMore.image = #imageLiteral(resourceName: "advance")
        self.showMore(isShow: true, height: 0)
        self.heightView.constant  = 600
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
        if self.isRale == false
        {
            for type in Util.shared.listCategoryRent {
                let picker = ModelPicker(id: Int(type.id)!, name: type.name)
                picker.index = index
                index += 1
                self.listPickerTypeProject.append( picker)
            }
        }
        else
        {
            for type in Util.shared.listCategorySale {
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
    
    func loadWard(idCity:String,idDistrict:String)
    {
        self.showHUD("")
        self.listWard = []
        var listWare:[WaredModel] = []
        APIClient.shared.getWard(id_city: idCity, id_district: idDistrict).asObservable().bind(onNext: { result in
            for data in result.dataArray
            {
                if let dic = data as? [String:Any]
                {
                    let city = WaredModel(JSON: dic)
                    listWare.append(city!)
                }
            }
            var index:Int = 0
            for ware in listWare {
                let picker = ModelPicker(id: Int(ware.id)!, name: ware.name)
                picker.index = index
                index += 1
                self.listWard.append(picker)
            }
            self.hideHUD()
        }).disposed(by: self.disposeBag)
    }
    
    func showMore(isShow:Bool,height:CGFloat)
    {
        self.wards.isHidden = isShow
        self.nameHome.isHidden = isShow
        self.bedroom.isHidden = isShow
        self.heightViewHome.constant = height
        self.heightWards.constant = height
        self.heightBedroom.constant = height
        
    }
    
    @IBAction func selectTypeButtonDidTap(_ sender: Any) {
        self.pickerView.listData = self.listPickerTypeProject
        self.pickerView.config.startIndex = self.indexTypeProject
        self.pickerView.status = 1
        self.pickerView.show(inVC: self)
    }
    
    @IBAction func selectCityButtonDidTap(_ sender: Any) {
        self.pickerView.listData = self.listPickerCity
        self.pickerView.config.startIndex = self.indexCity
        self.pickerView.status = 2
        self.pickerView.show(inVC: self)
        
    }
    
    @IBAction func selectDistrictButtonDidTap(_ sender: Any) {
        if self.idCity == "null"
        {
            self.showAlert("Bạn chưa chọn tỉnh thành")
            return
        }
        self.pickerView.listData = self.listPickerDistrict
        self.pickerView.config.startIndex = self.indexDistrict
        self.pickerView.status = 3
        self.pickerView.show(inVC: self)
    }
    
    @IBAction func selectMonneyButtonDidTap(_ sender: Any) {
        if self.isRale == true
        {
            self.pickerView.listData = self.listPicker
        }
        else
        {
             self.pickerView.listData = self.listPickerRent
        }
        self.pickerView.config.startIndex = self.indexPrice
        self.pickerView.status = 4
        self.pickerView.show(inVC: self)
        
    }
    
    @IBAction func selectWardsButtonDidTap(_ sender: Any) {
        if self.idCity == "null" && self.idDistrict == "null"
        {
            self.showAlert("Bạn chưa chọn tỉnh thành")
            return
        }
        if self.listWard.count == 0
        {
            self.showAlert("Địa chỉ bạn chọn không có phường/xã")
            return
        }
        self.pickerView.listData = self.listWard
        self.pickerView.config.startIndex = self.indexWard
        self.pickerView.status = 6
        self.pickerView.show(inVC: self)
        
    }
    @IBAction func showBedRoomButtonDidTap(_ sender: Any) {
        self.pickerView.listData = self.listNumberBedRoom
        self.pickerView.config.startIndex = self.indexBedroom
        self.pickerView.status = 7
        self.pickerView.show(inVC: self)
    }
    @IBAction func showDirectionButtonDidTap(_ sender: Any) {
        self.pickerView.listData = self.listDirection
        self.pickerView.config.startIndex = self.indeDirection
        self.pickerView.status = 8
        self.pickerView.show(inVC: self)
    }
    
    @IBAction func selectAcreageButtonDidTap(_ sender: Any) {
        self.pickerView.listData = self.listAcreage
        self.pickerView.config.startIndex = 0
        self.pickerView.status = 5
        self.pickerView.show(inVC: self)
    }
    
    @IBAction func searchButtonDidTap(_ sender: Any) {
        self.popToView()
        self.titles = self.titleSearch.text!
        if self.titleSearch.text?.count == 0
        {
            self.titles = "null"
        }
        
        self.delegate?.searchLand(self, self.idProject, self.titles, self.type, self.idCity, self.idWards, self.are_min, self.are_max, self.pricae_min, self.price_max, self.idDistrict, self.idBedRoom, self.idDirection)
    }
    
    @IBAction func moreButtonDidTap(_ sender: Any) {
        if isShow == false
        {
            self.showMore(isShow: false, height: 50)
            self.isShow = true
            self.heightView.constant = 800
            self.imageMore.image = #imageLiteral(resourceName: "advance2")
        }
        else
        {
            self.showMore(isShow: true, height: 0)
            self.isShow = false
            self.heightView.constant  = 600
            self.imageMore.image = #imageLiteral(resourceName: "advance")
        }
    }
    
    
    
}

extension SearchLandForSaleViewController:PickerViewDelegate
{
    func miPickerViewDidCancelSelection(_ amPicker: PickerView) {
        
    }
    
    func miPickerView(_ amPicker: PickerView, didSelect picker: ModelPicker) {
        switch amPicker.status
        {
        case 1:
            self.type = String(picker.id)
            self.typeBDS.text = picker.name
            self.indexTypeProject = picker.index
        case 2:
            self.idCity = String(picker.id)
            self.nameCity.text = picker.name
            self.idDistrict = "null"
            self.indexDistrict = 0
            self.indexWard = 0
            self.idWards = "null"
            self.wards.text = "Chọn phường/Xã"
            self.nameDistrict.text = "Chọn quận/Huyện"
            self.loadDistrict(idCity: self.idCity)
            self.indexCity = picker.index
            break
        case 3:
            self.idDistrict = String(picker.id)
            self.nameDistrict.text = picker.name
            self.idWards = "null"
            self.wards.text = "Chọn phường/Xã"
            self.indexWard = 0
            self.loadWard(idCity: self.idCity, idDistrict: self.idDistrict)
            self.indexDistrict = picker.index
        case 4:
        
            self.priceBDS.text = picker.name
            self.indexPrice = picker.id - 1
            if self.isRale == true
            {
                self.getDataPrice(picker: picker)
            }
            else
            {
                self.getDataPriceRent(picker: picker)
            }
        case 5:
            self.areLabel.text =  picker.name
            self.indexAcreage = picker.id - 1
            self.getDataAcreage(picker: picker)
        case 6:
            self.wards.text =  picker.name
            self.idWards = String(picker.id)
            self.indexWard = picker.index
            self.getDataAcreage(picker: picker)
        case 7:
            self.bedroom.text =  picker.name
            self.idBedRoom = String(picker.id)
            self.indexBedroom = picker.id - 1
        case 8:
            self.nameHome.text =  picker.name
            self.idDirection = String(picker.id)
            self.indeDirection = picker.id - 1

        default:
            break
        }
    }
    
    func getDataAcreage(picker: ModelPicker)
    {
        
        switch picker.id
        {
        case 1:
            self.are_min = "null"
            self.are_max = "30"
        case 2:
            self.are_min = "30"
            self.are_max = "50"
        case 3:
            self.are_min = "50"
            self.are_max = "100"
        case 4:
            self.are_min = "100"
            self.are_max = "150"
        case 5:
            self.are_min = "200"
            self.are_max = "300"
        case 6:
            self.are_min = "300"
            self.are_max = "500"
        case 7:
            self.are_min = "500"
            self.are_max = "700"
        case 8:
            self.are_min = "700"
            self.are_max = "1000"
        case 9:
            self.are_min = "1000"
            self.are_max = "null"
        
        default:
           break
        }
    }
    
    func getDataPrice(picker: ModelPicker)
    {
       
        switch picker.id
        {
        case 1:
            self.pricae_min = "null"
            self.price_max = "300"
        case 2:
            self.pricae_min = "300"
            self.price_max = "500"
        case 3:
            self.pricae_min = "700"
            self.price_max = "1000"
        case 4:
            self.pricae_min = "1000"
            self.price_max = "2000"
        case 5:
            self.pricae_min = "2000"
            self.price_max = "3000"
        case 6:
            self.pricae_min = "3000"
            self.price_max = "5000"
        case 7:
            self.pricae_min = "5000"
            self.price_max = "7000"
        case 8:
            self.pricae_min = "7000"
            self.price_max = "10000"
        case 9:
            self.pricae_min = "10000"
            self.price_max = "20000"
        case 10:
            self.pricae_min = "20000"
            self.price_max = "30000"
        default:
            self.pricae_min = "30000"
            self.price_max = "null"
        }
    }
    
    func getDataPriceRent(picker: ModelPicker)
    {
        
        switch picker.id
        {
        case 1:
            self.pricae_min = "null"
            self.price_max = "3"
        case 2:
            self.pricae_min = "3"
            self.price_max = "5"
        case 3:
            self.pricae_min = "5"
            self.price_max = "5"
        case 4:
            self.pricae_min = "7"
            self.price_max = "10"
        case 5:
            self.pricae_min = "10"
            self.price_max = "20"
        case 6:
            self.pricae_min = "20"
            self.price_max = "30"
       
        default:
            self.pricae_min = "30"
            self.price_max = "null"
        }
    }
}


