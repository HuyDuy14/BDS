
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

    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var headerView: HeaderViewController!
    @IBOutlet weak var sumPrice: UILabel!
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
    // Hướng ban công(directionOfBalcony)
    @IBOutlet weak var directionOfBalcony: UILabel!
    @IBOutlet weak var imagedirectionOfBalcony: UIImageView!
    @IBOutlet weak var heightdirectionOfBalcony: NSLayoutConstraint!
    // Số tầng(numberOfFloors)
    @IBOutlet weak var numberOfFloors: KMPlaceholderTextView!
    @IBOutlet weak var heightNumberOfFloors: NSLayoutConstraint!
    // Số nhà để xe (garageNumber)
    @IBOutlet weak var garageNumber: KMPlaceholderTextView!
    @IBOutlet weak var heightGarageNumber: NSLayoutConstraint!
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
    // Image
    let imagePicker = UIImagePickerController()
    var image:UIImage?
    @IBOutlet weak var imageNews: UIImageView!
    
    // Number toilet
    
    @IBOutlet weak var numberToilet: KMPlaceholderTextView!
    @IBOutlet weak var heightNumberToilet: NSLayoutConstraint!
    //HeightView
    @IBOutlet weak var heightView: NSLayoutConstraint!
    var heightViewContraint:CGFloat = 2450
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var codeTextFied: UITextField!
    
    // Contact Information
    @IBOutlet weak var imageContact: UIImageView!
    @IBOutlet weak var nameContact: UITextField!
    @IBOutlet weak var heightNameConact: NSLayoutConstraint!
    @IBOutlet weak var addressContact: UITextField!
    @IBOutlet weak var heightAddressContact: NSLayoutConstraint!
    @IBOutlet weak var phoneContact: UITextField!
    @IBOutlet weak var heightPhontContact: NSLayoutConstraint!
    @IBOutlet weak var mobileContact: UITextField!
    @IBOutlet weak var heightMobileContact: NSLayoutConstraint!
    @IBOutlet weak var emailContact: UITextField!
    @IBOutlet weak var heightEmailContact: NSLayoutConstraint!
    
    
    var isCheck:Bool = false
    //Property
    var isShowInfor:Bool = true
    var isShowInforBasic:Bool = true
    var isInforOther:Bool = true
    var isContactInfor:Bool = true
    
    // DatePicker
    var startDate:Date = Date()
    var endDate:Date = Date()
    var datePicker = MIDatePicker.getFromNib()
    
    // PickerView
    var listTypeLand:[ModelPicker] = [ModelPicker(id: 1, name: "Nhà đất bán"),ModelPicker(id: 2, name: "Nhà đất cho thuê")]
    var listTypeNews:[ModelPicker] = [ModelPicker(id: 2, name: "Tin miễn phí"),ModelPicker(id: 3, name: "Tin vip 3"),ModelPicker(id: 4, name: "Tin vip 2"),ModelPicker(id: 5, name: "Tin vip 1"),ModelPicker(id: 6, name: "Tin siêu vip")]
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
    var indexDirectionOfBalcony = 0
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
    var idDirectionOfBalcony = "null"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDelegate()
        self.isShowInforView(isShow: self.isShowInfor)
        self.isShowInforBasic(isShow: self.isShowInforBasic)
        self.isShowInforOther(isShow: self.isInforOther)
        self.isShowContactInformation(isShow: self.isContactInfor)
        self.settingColorIcon()
        self.loadDataCity()
        self.loadData()
    
    }
    
    func setDelegate()
    {
        self.imagePicker.delegate = self
        self.headerView.delegate = self
        self.headerView.setTitleView(title: "Đăng tin ", infor: "Đăng tin nhanh")
        self.datePicker.delegate = self
        self.pickerView.delegate = self
    }
    
    func loadData()
    {
        
        self.startDate = Date()
        self.endDate = self.startDate.addingTimeInterval(7 * 86400)
        self.startDateLabel.text = self.startDate.dateFormatString(formater: "dd/MM/yyyy")
        self.endDateLabel.text = self.endDate.dateFormatString(formater: "dd/MM/yyyy")
        self.typeNews.text = listTypeNews[0].name
        self.idTypeNews = listTypeNews[0].id
        self.nameCompany.text = listTypeCompany[0].name
        self.idCompany = String(listTypeCompany[0].id)
        self.nameUser.text = listTypeUser[1].name
        self.idTypeUser = String(listTypeUser[1].id)
        self.indexTypeUser = 1
        self.formLabel.text = listTypeLand[0].name
        self.indexTypeLand = 0
        self.typeLand.text = "Chọn loại BĐS"
        self.idLandSale = "null"
        self.idTypeLand = "sale"
        self.loadPrice()
        self.setDataPickerLand()
        self.codeLabel.text = self.randomString(length: 5)
    }
    
    func resetData()
    {
        self.idBedroom = "null"
        self.idCompany = "null"
        self.idTypeUser = "null"
        self.idTypeNews = 2
        self.idTypeLand = "null"
        self.idLandSale = "null"
        self.idCity = "null"
        self.idProject = "0"
        self.idDistrict = "null"
        self.idDirection = "null"
        self.idWards = "null"
        self.idTypePrice = "null"
        self.indexTypePrice = 0
        self.indextypeNews = 0
        self.indexTypeLand = 0
        self.indexlandSale = 0
        self.indexCity = 0
        self.indexDistrict = 0
        self.indexWard = 0
        self.indexTypeUser = 0
        self.indeDirection = 0
        self.indexTypeCompany = 0
        self.indexTypeProject = 0
        self.indexBedroom = 0
        self.loadData()
        self.inforViewTextView.text = ""
        self.titleTextField.text = ""
        self.typeLand.text = "Loại BĐS"
        self.cityName.text = "Tỉnh/Thành phố"
        self.districtLabel.text = "Chọn Quận/Huyện"
        self.wardLabel.text = "Chọn Phường/Xã"
        self.nameProjects.text = "Chọn dự án"
        self.address.text = ""
        self.acreageLabel.text = ""
        self.priceLabel.text = ""
        self.emailContact.text = ""
        self.nameContact.text = ""
        self.phoneContact.text = ""
        self.addressContact.text = ""
        self.mobileContact.text = ""
        self.typePrice.text = "Đơn vị"
        self.facadeTextField.text = ""
        self.distanceTextField.text = ""
        self.directionOfHouse.text = "Hướng nhà"
        self.directionBalcony.text = "Số phòng ngủ"
        self.furnitureTextView.text = ""
        self.image = nil
        self.imageNews.image = #imageLiteral(resourceName: "icon_plachoder_chat")
    }
    
    func settingColorIcon()
    {
        self.imagedropDownInfor.tintColor = UIColor(netHex: 0x19846B)
        self.imageInforBase.tintColor = UIColor(netHex: 0x19846B)
        self.imageInforOther.tintColor = UIColor(netHex: 0x19846B)
        self.imageContact.tintColor = UIColor(netHex: 0x19846B)
    }
    
    func isShowInforView(isShow:Bool)
    {
        self.inforViewTextView.isHidden = isShow
        if isShow == true
        {
            self.imagedropDownInfor.image = #imageLiteral(resourceName: "icondown")
            self.heightInforView.constant = 0
            self.heightViewContraint = self.heightViewContraint - 50
        }
        else
        {
            self.imagedropDownInfor.image = #imageLiteral(resourceName: "icon_up")
            self.heightInforView.constant = 50
            self.heightViewContraint = self.heightViewContraint + 50
            
        }
        self.heightView.constant = self.heightViewContraint
    }
    
    func loadPrice()
    {
         self.sumPrice.text = "Thành tiền: \(0) VND"
        self.showHUD("")
        let start = self.startDate.dateFormatString(formater: "yyyy-MM-dd")
        let end =  self.endDate.dateFormatString(formater: "yyyy-MM-dd")
    
        APIClient.shared.getPrice(start: start, finish: end, type: self.idTypeNews).asObservable().bind(onNext: {result in
            self.sumPrice.text = "Thành tiền: \(result.price) VND"
            self.hideHUD()
        }).disposed(by: self.disposeBag)
    }
    
    func randomString(length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0..<length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
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
        self.directionOfBalcony.isHidden = isShow
        self.imagedirectionOfBalcony.isHidden = isShow
        self.numberOfFloors.isHidden = isShow
        self.garageNumber.isHidden = isShow
        self.numberToilet.isHidden = isShow
      
        if isShow == true
        {
            self.imageInforOther.image = #imageLiteral(resourceName: "icondown")
            self.heightFacade.constant = 0
            self.heightDistance.constant = 0
            self.heightDirectionOfHouse.constant = 0
            self.heightDirectionBalcony.constant = 0
            self.heightFurnitureTextView.constant = 0
            self.heightdirectionOfBalcony.constant = 0
            self.heightNumberOfFloors.constant = 0
            self.heightGarageNumber.constant = 0
            self.heightNumberToilet.constant = 0
            self.heightViewContraint = self.heightViewContraint - 500
        }
        else
        {
            self.imageInforOther.image = #imageLiteral(resourceName: "icon_up")
            self.heightFacade.constant = 50
            self.heightDistance.constant = 50
            self.heightDirectionOfHouse.constant = 50
            self.heightDirectionBalcony.constant = 50
            self.heightFurnitureTextView.constant = 50
            self.heightdirectionOfBalcony.constant = 50
            self.heightNumberOfFloors.constant = 50
            self.heightGarageNumber.constant = 50
            self.heightNumberToilet.constant = 50
            self.heightViewContraint = self.heightViewContraint + 500
        }
        self.heightView.constant = self.heightViewContraint
    }
    
    func isShowInforOtherSaleRent(isShow:Bool,id:Int)
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
        self.directionOfBalcony.isHidden = isShow
        self.imagedirectionOfBalcony.isHidden = isShow
        self.numberOfFloors.isHidden = isShow
        self.garageNumber.isHidden = isShow
        self.numberToilet.isHidden = isShow
        if isShow == true
        {
            self.imageInforOther.image = #imageLiteral(resourceName: "icondown")
            self.heightFacade.constant = 0
            self.heightDistance.constant = 0
            self.heightDirectionOfHouse.constant = 0
            self.heightDirectionBalcony.constant = 0
            self.heightFurnitureTextView.constant = 0
            self.heightdirectionOfBalcony.constant = 0
            self.heightNumberOfFloors.constant = 0
            self.heightGarageNumber.constant = 0
            self.heightNumberToilet.constant = 0
            self.heightViewContraint = self.heightViewContraint - 500
        }
        else
        {
            self.imageInforOther.image = #imageLiteral(resourceName: "icon_up")
            self.heightFacade.constant = 50
            self.heightDistance.constant = 50
            self.heightDirectionOfHouse.constant = 50
            self.heightDirectionBalcony.constant = 50
            self.heightFurnitureTextView.constant = 50
            self.heightdirectionOfBalcony.constant = 50
            self.heightNumberOfFloors.constant = 50
            self.heightGarageNumber.constant = 50
            self.heightNumberToilet.constant = 0
            self.heightViewContraint = self.heightViewContraint + 500
        }
        
        if (id == 114 || id == 56) && isShow == false
        {
            self.directionBalcony.isHidden = true
            self.imageDirectionBalcony.isHidden = true
            self.directionOfBalcony.isHidden = true
            self.imagedirectionOfBalcony.isHidden = true
            self.numberOfFloors.isHidden = true
            self.garageNumber.isHidden = true
            
            self.heightDirectionBalcony.constant = 0
            self.heightdirectionOfBalcony.constant = 0
            self.heightNumberOfFloors.constant = 0
            self.heightGarageNumber.constant = 0
            self.heightViewContraint = self.heightViewContraint - 300
            
        }
      
        if (id == 3 || id == 4) && isShow == false
        {
            self.directionBalcony.isHidden = true
            self.imageDirectionBalcony.isHidden = true
            self.furnitureTextView.isHidden = true
            self.directionOfBalcony.isHidden = true
            self.imagedirectionOfBalcony.isHidden = true
            self.numberOfFloors.isHidden = true
            self.garageNumber.isHidden = true
            self.numberToilet.isHidden = true
            
            self.heightDirectionBalcony.constant = 0
            self.heightFurnitureTextView.constant = 0
            self.heightdirectionOfBalcony.constant = 0
            self.heightNumberOfFloors.constant = 0
            self.heightGarageNumber.constant = 0
            self.heightNumberToilet.constant = 0
            self.heightViewContraint = self.heightViewContraint - 350
            
        }
        
        if (id == 8 || id == 79) && isShow == false
        {
            self.facadeTextField.isHidden = true
            self.mFacadeLabel.isHidden = true
            self.distanceTextField.isHidden = true
            self.mDistance.isHidden = true
            self.numberOfFloors.isHidden = true
            self.garageNumber.isHidden = true
            self.heightFacade.constant = 0
            self.heightDistance.constant = 0
            self.heightNumberOfFloors.constant = 0
            self.heightGarageNumber.constant = 0
            self.heightViewContraint = self.heightViewContraint - 300
            
        }
        self.heightView.constant = self.heightViewContraint
    }
    
    func isShowContactInformation(isShow:Bool)
    {
        self.mobileContact.isHidden = isShow
        self.nameContact.isHidden = isShow
        self.phoneContact.isHidden = isShow
        self.addressContact.isHidden = isShow
        self.emailContact.isHidden = isShow
        if isShow == true
        {
            self.imageContact.image = #imageLiteral(resourceName: "icondown")
            self.heightNameConact.constant = 0
            self.heightAddressContact.constant = 0
            self.heightPhontContact.constant = 0
            self.heightMobileContact.constant = 0
            self.heightEmailContact.constant = 0
            self.heightViewContraint = self.heightViewContraint - 300
        }
        else
        {
            self.heightNameConact.constant = 50
            self.heightAddressContact.constant = 50
            self.heightPhontContact.constant = 50
            self.heightMobileContact.constant = 50
            self.heightEmailContact.constant = 50
            self.imageContact.image = #imageLiteral(resourceName: "icon_up")
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
            if Int(type.id) == 3 || Int(type.id) == 4 || Int(type.id) == 114 || Int(type.id) == 79
            {
                print("a")
            }
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
            listDictrict.sort(by: { (dis1, dis2) -> Bool in
                return dis1.name < dis2.name
            })
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
            self.listPickerTypeProject.insert(ModelPicker(id: 1000000, name: "Mặc định"), at: 0)
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
        if self.idLandSale != "null"
        {
            self.isShowInforOtherSaleRent(isShow: self.isInforOther, id: Int(self.idLandSale)!)
        }
        else
        {
             self.isShowInforOther(isShow: self.isInforOther)
        }
    }
    
    @IBAction func contactButtonDidTap(_ sender: Any) {
        if self.isContactInfor == false
        {
            self.isContactInfor = true
            
        }
        else
        {
            self.isContactInfor = false
        }
        self.isShowContactInformation(isShow: self.isContactInfor)
    }
    
    // DatePicker
    
    @IBAction func startDateButtonDidTap(_ sender: Any) {
        self.datePicker.config.startDate = self.startDate
        self.datePicker.datePicker.minimumDate = Date()
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
    @IBAction func selectDirectionOfBalconyButtonDidTap(_ sender: Any) {
        self.pickerView.listData = self.listDirection
        self.pickerView.config.startIndex = self.indexDirectionOfBalcony
        self.pickerView.status = 12
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
    
    @IBAction func showImageButtonDidTap(_ sender: Any) {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        // 2
        let deleteAction = UIAlertAction(title: "Photo", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.selectImageFrom(resource: true)
            
        })
        let saveAction = UIAlertAction(title: "Camera", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.selectImageFrom(resource: false)
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func isCheckButtonDidTap(_ sender: Any) {
        if self.isCheck == false
        {
            self.btnDone.setImage(#imageLiteral(resourceName: "icon_checked"), for: .normal)
            self.isCheck = true
        }
        else
        {
            self.btnDone.setImage(nil, for: .normal)
            self.isCheck = false
        }
    }
    @IBAction func resetCodeButtonDidTap(_ sender: Any) {
        self.codeLabel.text = self.randomString(length: 5)
    }
    
    
    @IBAction func postNewsButtonDidTap(_ sender: Any) {
       
        if self.titleTextField.text?.count == 0
        {
            self.showAlert("Bạn chưa nhập tiêu đề")
            return
        }
        
        if self.inforViewTextView.text.count == 0
        {
            self.showAlert("Bạn chưa nhập thông tin mô tả")
            return
        }
        
        if self.idTypeUser == "null"
        {
            self.showAlert("Bạn chưa cho biết bạn là ai")
            return
        }
        
        if self.idLandSale == "null"
        {
            self.showAlert("Bạn chưa chọn loại BĐS")
            return
        }
        
        if self.idTypeLand == "null"
        {
            self.showAlert("Bạn chưa chọn loại dự án")
            return
            
        }
        
        if self.address.text?.count == 0 {
            self.showAlert("Bạn chưa nhập địa chỉ BĐS")
            return
        }
        
        if self.idCity == "null"
        {
            self.showAlert("Bạn chưa chọn Tỉnh/Thành phố")
            return
        }
        
        if self.idDistrict == "null"
        {
            self.showAlert("Bạn chưa chọn Quận/Huyện")
            return
        }
        
        if self.startDate.timeIntervalSince1970 >  self.endDate.timeIntervalSince1970 - (7 * 86400)
        {
            self.showAlert("Ngày kết thúc phải lớn hơn ngày bắt đầu ít nhất 7 ngày")
            return
        }
        
        if self.isCheck == false
        {
            self.showAlert("Bạn chưa đồng ý với điều khoản sử dụng của ứng dụng")
            return
        }
        
        if !(self.codeLabel.text?.elementsEqual(self.codeTextFied?.text ?? ""))!
        {
            self.showAlert("Mã bảo mật chưa đúng")
            return
        }

        
        if !(self.phoneContact.text?.isPhone())!
        {
            self.showAlert("Bạn nhập sai định dạng số điện thoại")
            return
        }
        
        if !(self.mobileContact.text?.isPhone())!
        {
            self.showAlert("Bạn nhập sai định dạng số điện thoại của bạn")
            return
        }
        
        if (self.mobileContact.text?.count == 0)
        {
            self.showAlert("Bạn chưa nhập số điện thoại của bạn vui lòng nhập cách thức liên hệ với bạn")
            self.mobileContact.becomeFirstResponder()
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
        
        APIClient.shared.postNews(post_type: self.idTypeNews, startDate:start , endDate:end, user_type: self.idTypeUser, title: self.titleTextField.text!, project_id: self.idProject, type_bds: self.idLandSale, type: self.idTypeLand, city: self.idCity, ward: self.idWards, area: self.acreageLabel.text!, price: self.priceLabel.text!, price_type: self.idTypePrice, district: self.idDistrict, address: self.address.text!, des: self.inforViewTextView.text, numberbedroom: self.idBedroom, direction: self.idDirection, image: self.image, poster_name: self.nameContact.text!,poster_address: self.addressContact.text!,poster_phone: self.phoneContact.text!,poster_mobile: self.mobileContact.text!,poster_email: self.emailContact.text!,completion: {result in
            self.showAlert("Bạn đã đăng tin thành công! Tin của bạn sẽ được xét duyệt trong vòng vài giờ, hay kiểm tra trong phần quản lý tin đăng của tôi")
            self.resetData()
            self.isShowInfor = true
            self.isShowInforBasic = true
            self.isInforOther = true
            self.isCheck = false
            self.btnDone.setImage(nil, for: .normal)
            self.isShowInforView(isShow: self.isShowInfor)
            self.isShowInforBasic(isShow: self.isShowInforBasic)
            self.isShowInforOther(isShow: self.isInforOther)
            self.hideHUD()
        })

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
            self.endDate = date.addingTimeInterval(7*86400)
            self.endDateLabel.text = self.endDate.dateFormatString(formater: "dd/MM/yyyy")
            self.startDateLabel.text = date.dateFormatString(formater: "dd/MM/yyyy")
            
        }
        else
        {
            self.endDate = date
            self.endDateLabel.text = date.dateFormatString(formater: "dd/MM/yyyy")
        }
        self.loadPrice()
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
            self.loadPrice()
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
            if self.isInforOther == false
            {
                if self.idLandSale != "null"
                {
                    self.isShowInforOtherSaleRent(isShow: self.isInforOther, id: Int(self.idLandSale)!)
                }
            }
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
            if picker.id == 1000000
            {
                self.nameProjects.text = "Chọn dự án"
                self.idProject = "0"
            }
            else
            {
                self.nameProjects.text = picker.name
                self.idProject = String(picker.id)
            }
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
        case 12:
            self.directionOfBalcony.text = picker.name
            self.idDirectionOfBalcony = String(picker.id)
            self.indexDirectionOfBalcony = index
        default:
            break
        }
    }
    
    func miPickerViewDidCancelSelection(_ amPicker: PickerView) {
        
    }
    
    func miPickerView(_ amPicker: PickerView, didSelect picker: ModelPicker) {
        
    }
}

extension PostNewsViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageNews.contentMode = .scaleToFill
            let newImage:UIImage = pickedImage.resizeImage(newWidth: 250)
            self.imageNews.image = newImage
            self.image = newImage
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func selectImageFrom(resource: Bool) {
        
        
        imagePicker.allowsEditing = true
        
        if resource {
            imagePicker.sourceType = .photoLibrary
        } else {
            imagePicker.sourceType = .camera
        }
        
        
        present(imagePicker, animated: true, completion: nil)
        
        
    }
}
