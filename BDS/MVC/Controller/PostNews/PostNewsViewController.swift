
//
//  PostNewsViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/19/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import KMPlaceholderTextView
import RxCocoa
import RxSwift

class PostNewsViewController: BaseViewController {

    @IBOutlet weak var headerView: HeaderViewController!
    let disposeBag = DisposeBag()
    //Date
    @IBOutlet weak var typeNews: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    //dropdown infor
    @IBOutlet weak var imagedropDownInfor: UIImageView!
    @IBOutlet weak var heightInforView: NSLayoutConstraint!
    @IBOutlet weak var inforViewTextView: KMPlaceholderTextView!
    
    // Infor basic
    @IBOutlet weak var imageInforBase: UIImageView!
    
    @IBOutlet weak var imageNameUser: UIImageView!
    @IBOutlet weak var heightNameUserView: NSLayoutConstraint!
    @IBOutlet weak var nameUser: UILabel!
    
    @IBOutlet weak var nameCompany: UILabel!
    @IBOutlet weak var imageNameCompany: UIImageView!
    @IBOutlet weak var heightNameCompany: NSLayoutConstraint!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var heightViewTitle: NSLayoutConstraint!
    //Hình thức (Form)
    @IBOutlet weak var imageFormLabel: UIImageView!
    @IBOutlet weak var formLabel: UILabel!
    @IBOutlet weak var heightForm: NSLayoutConstraint!
    // Loại bds (typeLand)
    @IBOutlet weak var typeLand: UILabel!
    @IBOutlet weak var imageTypeLand: UIImageView!
    @IBOutlet weak var heightTypeLand: NSLayoutConstraint!
    //City
    @IBOutlet weak var heightCity: NSLayoutConstraint!
    @IBOutlet weak var imageCity: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    // Quận /huyện (County/District)
    @IBOutlet weak var imageDistrict: UIImageView!
    @IBOutlet weak var heightDistrict: NSLayoutConstraint!
    @IBOutlet weak var districtLabel: UILabel!
    //Phường (Ward)
    @IBOutlet weak var heightWard: NSLayoutConstraint!
    @IBOutlet weak var imageWard: UIImageView!
    @IBOutlet weak var wardLabel: UILabel!
    //Dự án (Projects)
    @IBOutlet weak var nameProjects: UILabel!
    @IBOutlet weak var imageProject: UIImageView!
    @IBOutlet weak var heightProject: NSLayoutConstraint!
    // Diện tích (Acreage)
    @IBOutlet weak var acreageLabel: UITextField!
    @IBOutlet weak var m2Label: UILabel!
    @IBOutlet weak var heightAcreage: NSLayoutConstraint!
    // Giá(price )
    @IBOutlet weak var priceLabel: UITextField!
    @IBOutlet weak var heightPrice: NSLayoutConstraint!
    //price type
    @IBOutlet weak var heightPriceType: NSLayoutConstraint!
    @IBOutlet weak var imageTypePrice: UIImageView!
    @IBOutlet weak var typePrice: UILabel!
    // Địa chỉ(address)
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var heightAddress: NSLayoutConstraint!
    
    // Infor other
    @IBOutlet weak var imageInforOther: UIImageView!
    //Mặt tiền (Facade)
    @IBOutlet weak var facadeTextField: UITextField!
    @IBOutlet weak var mFacadeLabel: UILabel!
    @IBOutlet weak var heightFacade: NSLayoutConstraint!
    // Khoảng cách đường vào (Distance)
    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var mDistance: UILabel!
    @IBOutlet weak var heightDistance: NSLayoutConstraint!
    // Hướng nhà (directionOfHouse)
    @IBOutlet weak var directionOfHouse: UILabel!
    @IBOutlet weak var imageDirectionOfHouse: UIImageView!
    @IBOutlet weak var heightDirectionOfHouse: NSLayoutConstraint!
    //Hướng ban công (DirectionBalcony)
    @IBOutlet weak var directionBalcony: UILabel!
    @IBOutlet weak var imageDirectionBalcony: UIImageView!
    @IBOutlet weak var heightDirectionBalcony: NSLayoutConstraint!
    //Nôi Thất
    @IBOutlet weak var heightFurnitureTextView: NSLayoutConstraint!
    @IBOutlet weak var furnitureTextView: KMPlaceholderTextView!
    
    //HeightView
    @IBOutlet weak var heightView: NSLayoutConstraint!
   var heightViewContraint:CGFloat = 1500
    
    
    //Property
    var isShowInfor:Bool = true
    var isShowInforBasic:Bool = true
    var isInforOther:Bool = true
    
    // DatePicker
    var startDate:Date = Date()
    var endDate:Date = Date()
    var datePicker = MIDatePicker.getFromNib()
    // PickerView
    var listTypeLand:[ModelPicker] = [ModelPicker(id: 1, name: "Nhà đất bán"),ModelPicker(id: 2, name: "Nhà đất cho thuê")]
    var listTypeNews:[ModelPicker] = [ModelPicker(id: 2, name: "Tin miễn phí"),ModelPicker(id: 5, name: "Tin vip 1"),ModelPicker(id: 4, name: "Tin vip 2"),ModelPicker(id: 3, name: "Tin vip"),ModelPicker(id: 6, name: "Tin siêu vip")]
    var listDirection:[ModelPicker] =  [ModelPicker(id: 1, name: "Đông"),ModelPicker(id: 2, name: "Tây"),ModelPicker(id: 3, name: "Nam"),ModelPicker(id: 4, name: "Bắc"),ModelPicker(id: 5, name: "Đông-Bắc"),ModelPicker(id: 6, name: "Tây-Bắc"),ModelPicker(id: 7, name: "Đông-Nam"),ModelPicker(id: 8, name: "Tây-Nam")]
    var listTypePrice:[ModelPicker] = [ModelPicker(id: 1, name: "Triệu"),ModelPicker(id: 2, name: "Tỷ"),ModelPicker(id: 6, name: "Trăm nghìn/m2"),ModelPicker(id: 7, name: "Triệu/m2")]
    var listTypeUser:[ModelPicker] = [ModelPicker(id: 1, name: "Chính chủ"),ModelPicker(id: 2, name: "Môi giới"),ModelPicker(id: 3, name: "Chủ dự án"),ModelPicker(id: 4, name: "Khác")]
    var listTypeCompany:[ModelPicker] = [ModelPicker(id: 1, name: "Cá nhân"),ModelPicker(id: 2, name: "Doanh nghiệp")]
    var listNumberBedRoom:[ModelPicker] =  [ModelPicker(id: 1, name: "1"),ModelPicker(id: 2, name: "2"),ModelPicker(id: 3, name: "3"),ModelPicker(id: 4, name: "4"),ModelPicker(id: 5, name: "5"),ModelPicker(id: 6, name: "6"),ModelPicker(id: 7, name: "7"),ModelPicker(id: 8, name: "8"),ModelPicker(id: 9, name: "9"),ModelPicker(id: 10, name: "10")]
     var listLandSale:[ModelPicker] = []
    var listPickerCity:[ModelPicker] = []
    var listPickerDistrict:[ModelPicker] = []
    var listWard:[ModelPicker] = []
    var listPickerTypeProject:[ModelPicker] = []
    var pickerView = PickerView.getFromNib()
    
    // index select
    var indexTypePrice = 0
    var indextypeNews = 0
    var indexTypeLand = 0
    var indexlandSale = 0
    var indexCity = 0
    var indexDistrict = 0
    var indexWard = 0
    var indexTypeUser = 0
    var indeDirection = 0
    var indexTypeCompany = 0
    var indexTypeProject = 0
    var indexBedroom = 0
    // idSelect
    var idBedroom = "null"
    var idCompany = "null"
    var idTypeUser = "null"
    var idTypeNews = 2
    var idTypeLand = "null"
    var idLandSale = "null"
    var idCity = "null"
    var idProject = "0"
    var idDistrict = "null"
    var idDirection = "null"
    var idWards = "null"
    var idTypePrice = "null"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.setDelegate()
        self.isShowInforView(isShow: self.isShowInfor)
        self.isShowInforBasic(isShow: self.isShowInforBasic)
        self.isShowInforOther(isShow: self.isInforOther)
        self.settingColorIcon()
        self.loadDataCity()
    }
    
    func setDelegate()
    {
        self.headerView.delegate = self
        self.headerView.setTitleView(title: "Đăng tin ", infor: "Đăng tin nhanh")
        self.datePicker.delegate = self
        self.pickerView.delegate = self
    }
    
    func settingColorIcon()
    {
        self.imagedropDownInfor.tintColor = UIColor(netHex: 0x19846B)
        self.imageInforBase.tintColor = UIColor(netHex: 0x19846B)
        self.imageInforOther.tintColor = UIColor(netHex: 0x19846B)
    }
    
    func isShowInforView(isShow:Bool)
    {
        self.inforViewTextView.isHidden = isShow
        if isShow == true
        {
            self.imagedropDownInfor.image = #imageLiteral(resourceName: "icondown")
            self.heightInforView.constant = 0
            self.heightViewContraint = self.heightViewContraint - 100
        }
        else
        {
            self.imagedropDownInfor.image = #imageLiteral(resourceName: "icon_up")
            self.heightInforView.constant = 100
            self.heightViewContraint = self.heightViewContraint + 100
            
        }
        self.heightView.constant = self.heightViewContraint
    }
    
    func isShowInforOther(isShow:Bool)
    {
        
        self.facadeTextField.isHidden = isShow
        self.mFacadeLabel.isHidden = isShow
        self.distanceTextField.isHidden = isShow
        self.mDistance.isHidden = isShow
        self.directionOfHouse.isHidden = isShow
        self.imageDirectionOfHouse.isHidden = isShow
        self.directionBalcony.isHidden = isShow
        self.imageDirectionBalcony.isHidden = isShow
        self.furnitureTextView.isHidden = isShow
        if isShow == true
        {
            self.imageInforOther.image = #imageLiteral(resourceName: "icondown")
            self.heightFacade.constant = 0
            self.heightDistance.constant = 0
            self.heightDirectionOfHouse.constant = 0
            self.heightDirectionBalcony.constant = 0
            self.heightFurnitureTextView.constant = 0
            self.heightViewContraint = self.heightViewContraint - 300
        }
        else
        {
            self.imageInforOther.image = #imageLiteral(resourceName: "icon_up")
            self.heightFacade.constant = 50
            self.heightDistance.constant = 50
            self.heightDirectionOfHouse.constant = 50
            self.heightDirectionBalcony.constant = 50
            self.heightFurnitureTextView.constant = 100
            self.heightViewContraint = self.heightViewContraint + 300
        }
        self.heightView.constant = self.heightViewContraint
    }
    
    func isShowInforBasic(isShow:Bool)
    {
        self.nameUser.isHidden = isShow
        self.imageNameUser.isHidden = isShow
        self.nameCompany.isHidden = isShow
        self.imageNameCompany.isHidden = isShow
        self.titleTextField.isHidden = isShow
        self.formLabel.isHidden = isShow
        self.imageFormLabel.isHidden = isShow
        self.typeLand.isHidden = isShow
        self.imageTypeLand.isHidden = isShow
        self.cityName.isHidden = isShow
        self.imageCity.isHidden = isShow
        self.districtLabel.isHidden = isShow
        self.imageDistrict.isHidden = isShow
        self.wardLabel.isHidden = isShow
        self.imageWard.isHidden = isShow
        self.nameProjects.isHidden = isShow
        self.imageProject.isHidden = isShow
        self.m2Label.isHidden = isShow
        self.acreageLabel.isHidden = isShow
        self.priceLabel.isHidden = isShow
        self.address.isHidden = isShow
        self.typePrice.isHidden = isShow
        self.imageTypePrice.isHidden = isShow
        if isShow == true
        {
            self.imageInforBase.image = #imageLiteral(resourceName: "icondown")
            self.heightNameUserView.constant = 0
            self.heightNameCompany.constant = 0
            self.heightViewTitle.constant = 0
            self.heightForm.constant = 0
            self.heightTypeLand.constant = 0
            self.heightCity.constant = 0
            self.heightDistrict.constant = 0
            self.heightWard.constant = 0
            self.heightProject.constant = 0
            self.heightAcreage.constant = 0
            self.heightPrice.constant = 0
            self.heightAddress.constant = 0
            self.heightPriceType.constant = 0
            self.heightViewContraint = self.heightViewContraint - 650
        }
        else
        {
            self.imageInforBase.image = #imageLiteral(resourceName: "icon_up")
            self.heightNameUserView.constant = 50
            self.heightNameCompany.constant = 50
            self.heightViewTitle.constant = 50
            self.heightForm.constant = 50
            self.heightTypeLand.constant = 50
            self.heightCity.constant = 50
            self.heightDistrict.constant = 50
            self.heightWard.constant = 50
            self.heightProject.constant = 50
            self.heightAcreage.constant = 50
            self.heightPrice.constant = 50
            self.heightAddress.constant = 50
            self.heightPriceType.constant = 50
            self.heightViewContraint = self.heightViewContraint + 650
        }
        self.heightView.constant = self.heightViewContraint
    }
    
    // Mark: -LoadDataPicker
    
    func setDataPickerLand()
    {
        self.listLandSale = []
        var index:Int = 0
        for type in Util.shared.listCategorySale {
            let picker = ModelPicker(id: Int(type.id)!, name: type.name)
            picker.index = index
            index += 1
            self.listLandSale.append( picker)
        }
    }
    
    func setDataPickerRent()
    {
        self.listLandSale = []
        var index:Int = 0
        for type in Util.shared.listCategoryRent {
            let picker = ModelPicker(id: Int(type.id)!, name: type.name)
            picker.index = index
            index += 1
            self.listLandSale.append( picker)
        }
    }
    
    func loadDataCity()
    {
        self.listPickerCity = []
        var index:Int = 0
        for city in Util.shared.listCity {
            let picker = ModelPicker(id: Int(city.id)!, name: city.name)
            picker.index = index
            index += 1
            self.listPickerCity.append(picker)
        }
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
    
    func loadProjectOfCity(idCity:String)
    {
        self.showHUD("")
        self.listPickerTypeProject = []
        var listProject:[CategoryProjectModel] = []
        APIClient.shared.getCategoryProjectOfCity(id: idCity).asObservable().bind(onNext: { result in
            for data in result.dataArray
            {
                if let dic = data as? [String:Any]
                {
                    let project = CategoryProjectModel(JSON: dic)
                    listProject.append(project!)
                }
            }
            var index:Int = 0
            for project in listProject {
                let picker = ModelPicker(id: Int(project.id)!, name: project.title)
                picker.index = index
                index += 1
                self.listPickerTypeProject.append(picker)
            }
            self.hideHUD()
        }).disposed(by: self.disposeBag)
    }

    // MARK: - UIAaction
    @IBAction func inforButtonDidTap(_ sender: Any) {
        if self.isShowInfor == false
        {
            self.isShowInfor = true
            
        }
        else
        {
             self.isShowInfor = false
        }
        self.isShowInforView(isShow: self.isShowInfor)
    }
    
    @IBAction func inforBasicButtonDidTap(_ sender: Any) {
        if self.isShowInforBasic == false
        {
            self.isShowInforBasic = true
            
        }
        else
        {
            self.isShowInforBasic = false
        }
        self.isShowInforBasic(isShow: self.isShowInforBasic)
    }
    
    @IBAction func inforOtherButtonDidTap(_ sender: Any) {
        if self.isInforOther == false
        {
            self.isInforOther = true
            
        }
        else
        {
            self.isInforOther = false
        }
        self.isShowInforOther(isShow: self.isInforOther)
    }
    
    // DatePicker
    
    @IBAction func startDateButtonDidTap(_ sender: Any) {
        self.datePicker.config.startDate = self.startDate
        self.datePicker.isStart = true
        self.datePicker.show(inVC: self)
    }
    
    @IBAction func endDateButtonDidTap(_ sender: Any) {
        self.datePicker.config.startDate = self.endDate
        self.datePicker.isStart = false
        self.datePicker.show(inVC: self)
    }
    
    // infor basic
    @IBAction func selectTypeNewsButtonDidTap(_ sender: Any) {
        self.pickerView.listData = self.listTypeNews
        self.pickerView.status = 0
        self.pickerView.config.startIndex = self.indextypeNews
        self.pickerView.show(inVC: self)
    }
    
    @IBAction func selectTypeUser(_ sender: Any) {
        self.pickerView.listData = self.listTypeUser
        self.pickerView.status = 8
        self.pickerView.config.startIndex = self.indexTypeUser
        self.pickerView.show(inVC: self)
    }
    
    @IBAction func typeCompanyButtonDidTap(_ sender: Any) {
        self.pickerView.listData = self.listTypeCompany
        self.pickerView.status = 9
        self.pickerView.config.startIndex = self.indexTypeCompany
        self.pickerView.show(inVC: self)
    }
    
    @IBAction func selectFormButtonDidTap(_ sender: Any) {
        self.pickerView.listData = self.listTypeLand
        self.pickerView.status = 1
        self.pickerView.config.startIndex = self.indexTypeLand
        self.pickerView.show(inVC: self)
    }
    
    @IBAction func selectTypePriceButtonDidTap(_ sender: Any) {
        self.pickerView.listData = self.listTypePrice
        self.pickerView.status = 7
        self.pickerView.config.startIndex = self.indexTypePrice
        self.pickerView.show(inVC: self)
    }
    
    @IBAction func selectTypeLandButtonDidTap(_ sender: Any) {
        if self.idTypeLand == "null"
        {
            self.showAlert("Bạn chưa chọn hình thức bất động sản")
            return
        }
        self.pickerView.listData = self.listLandSale
        self.pickerView.status = 2
        self.pickerView.config.startIndex = self.indexlandSale
        self.pickerView.show(inVC: self)
    }
    
    @IBAction func selectCityButtonDidTap(_ sender: Any) {
        self.pickerView.listData = self.listPickerCity
        self.pickerView.config.startIndex = self.indexCity
        self.pickerView.status = 3
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
        self.pickerView.status = 4
        self.pickerView.show(inVC: self)
    }
    
    @IBAction func selectWardButtonDidTap(_ sender: Any) {
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
        self.pickerView.status = 5
        self.pickerView.show(inVC: self)
    }
    
    @IBAction func selectTypeProjects(_ sender: Any) {
        if self.idCity == "null"
        {
            self.showAlert("Bạn chưa chọn tỉnh thành")
            return
        }
        if self.listPickerTypeProject.count == 0
        {
            self.showAlert("Không có dự án nào trong tỉnh")
            return
        }
        self.pickerView.listData = self.listPickerTypeProject
        self.pickerView.config.startIndex = self.indexTypeProject
        self.pickerView.status = 6
        self.pickerView.show(inVC: self)
    }
    
    @IBAction func selectDirectionOfHouseButtonDidTap(_ sender: Any) {
        self.pickerView.listData = self.listDirection
        self.pickerView.config.startIndex = self.indeDirection
        self.pickerView.status = 10
        self.pickerView.show(inVC: self)
    }
    
    @IBAction func selectDirectionBalconyButtonDidTap(_ sender: Any) {
        self.pickerView.listData = self.listNumberBedRoom
        self.pickerView.config.startIndex = self.indexBedroom
        self.pickerView.status = 11
        self.pickerView.show(inVC: self)
    }
    
    
    @IBAction func postNewsButtonDidTap(_ sender: Any) {
        if self.inforViewTextView.text.count == 0
        {
            self.showAlert("Bạn chưa nhập thôn tin mô tả")
            return
        }
        if self.idTypeUser == "null"
        {
            self.showAlert("Bạn chưa cho biết bạn là ai")
            return
        }
        if self.titleTextField.text?.count == 0
        {
            self.showAlert("Bạn chưa nhập tiêu đề")
            return
        }
        if self.idLandSale == "null"
        {
            self.showAlert("Bạn chưa chọn hình thức giao dịch")
            return
        }
        
        if self.idTypeLand == "null"
        {
            self.showAlert("Bạn chưa chọn loại dự án")
            return
            
        }
        if self.idCity == "null"
        {
            self.showAlert("Bạn chưa chọn Tỉnh/Thành Phố")
            return
        }
        if self.idDistrict == "null"
        {
            self.showAlert("Bạn chưa chọn Quận/Huyện")
            return
        }
        
        self.showHUD("")
        var start = "null"
        var end =  "null"
        if self.startDateLabel.text != "Ngày bắt đầu"
        {
            start = self.startDate.dateFormatString(formater: "yyyy-MM-dd HH:mm:ss")
        }
        if self.endDateLabel.text != "Ngày kết thúc"
        {
            end = self.endDate.dateFormatString(formater: "yyyy-MM-dd HH:mm:ss")
        }
        
        APIClient.shared.postNews(post_type: self.idTypeNews, startDate:start , endDate:end, user_type: self.idTypeUser, title: self.titleTextField.text!, project_id: self.idProject, type_bds: self.idLandSale, type: self.idTypeLand, city: self.idCity, ward: self.idWards, area: self.acreageLabel.text!, price: self.priceLabel.text!, price_type: self.idTypePrice, district: self.idDistrict, address: self.address.text!, des: self.inforViewTextView.text, numberbedroom: self.idBedroom, direction: self.idDirection).asObservable().bind(onNext: {result in
                self.showAlert("Đăng thành công")
                self.hideHUD()
        }).disposed(by: self.disposeBag)

    }
    
}

extension PostNewsViewController:MIDatePickerDelegate
{
    func miDatePickerDidCancelSelection(_ amDatePicker: MIDatePicker) {
        
    }
    
    func miDatePicker(_ amDatePicker: MIDatePicker, didSelect date: Date) {
        if amDatePicker.isStart == true
        {
            self.startDate = date
            self.startDateLabel.text = date.dateFormatString(formater: "HH:mm dd/MM/yyyy")
            
        }
        else
        {
            self.endDate = date
            self.endDateLabel.text = date.dateFormatString(formater: "HH:mm dd/MM/yyyy")
        }
        
    }
}

extension PostNewsViewController:PickerViewDelegate
{
    func selectPickerView(_ Ppicker: PickerView, didSelect picker: ModelPicker, index: Int) {
        switch  Ppicker.status
        {
        case 0:
            self.typeNews.text = picker.name
            self.indextypeNews = index
            self.idTypeNews = picker.id
        case 1:
            self.formLabel.text = picker.name
            self.indexTypeLand = index
            self.typeLand.text = "Chọn loại BĐS"
            self.idLandSale = "null"
            if picker.id == 1
            {
                self.idTypeLand = "sale"
                self.setDataPickerLand()
            }
            else
            {
                self.idTypeLand = "rent"
                self.setDataPickerRent()
            }
        case 2:
            self.typeLand.text = picker.name
            self.indexlandSale = index
            self.idLandSale = String(picker.id)
        case 3:
            self.cityName.text = picker.name
            self.idCity = String(picker.id)
            self.idDistrict = "null"
            self.indexDistrict = 0
            self.indexWard = 0
            self.indexTypeProject = 0
            self.idWards = "null"
            self.idProject = "null"
            self.wardLabel.text = "Chọn Phường/Xã"
            self.districtLabel.text = "Chọn Quận/Huyện"
            self.nameProjects.text = "Chọn dự án"
            self.loadProjectOfCity(idCity: self.idCity)
            self.loadDistrict(idCity: self.idCity)
            self.indexCity = index
        case 4:
            self.idDistrict = String(picker.id)
            self.districtLabel.text = picker.name
            self.idWards = "null"
            self.indexWard = 0
            self.wardLabel.text = "Chọn phường/Xã"
            self.loadWard(idCity: self.idCity, idDistrict: self.idDistrict)
            self.indexDistrict = picker.index
        case 5 :
            self.wardLabel.text =  picker.name
            self.idWards = String(picker.id)
            self.indexWard = picker.index
        case 6:
            self.nameProjects.text = picker.name
            self.idProject = String(picker.id)
            self.indexTypeProject = index
        case 7:
            self.typePrice.text = picker.name
            self.idTypePrice = String(picker.id)
            self.indexTypePrice = index
        case 8:
            self.nameUser.text = picker.name
            self.idTypeUser = String(picker.id)
            self.indexTypeUser = index
        case 9:
            self.nameCompany.text = picker.name
            self.idCompany = String(picker.id)
            self.indexTypeCompany = index
        case 10:
            self.directionOfHouse.text = picker.name
            self.idDirection = String(picker.id)
            self.indeDirection = index
        case 11:
            self.directionBalcony.text = picker.name
            self.idBedroom = String(picker.id)
            self.indexBedroom = index
        default:
            break
        }
    }
    
    func miPickerViewDidCancelSelection(_ amPicker: PickerView) {
        
    }
    
    func miPickerView(_ amPicker: PickerView, didSelect picker: ModelPicker) {
        
    }
}
