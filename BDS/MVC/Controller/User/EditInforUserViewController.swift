//
//  EditInforUserViewController.swift
//  BDS
//
//  Created by Duy Huy on 11/30/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import RxSwift

class EditInforUserViewController: UITableViewController {
    //MARK: - Outlet
    @IBOutlet weak var avatarUser: UIImageView!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var birthday: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var newPass: UITextField!
    
    var datePicker = MIDatePicker.getFromNib()
    var pickerView = PickerView.getFromNib()
    var listPickerCity:[ModelPicker] = []
    var index:Int = 0
    var dateSelect:Date = Date()
    let userModel = Util.shared.currentUser
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillData()
        var index:Int = 0
        for city in Util.shared.listCity {
            let picker = ModelPicker(id: Int(city.id)!, name: city.name)
            picker.index = index
            if city.id == Util.shared.currentUser.city_id
            {
                self.index = index
            }
            index += 1
        
            self.listPickerCity.append( picker)
        }
    }
    
    func fillData()
    {
        self.avatarUser.layer.cornerRadius = self.avatarUser.frame.width / 2
        self.avatarUser.layer.masksToBounds = true
        self.avatarUser.setImageUrlNews(url: API.linkImage + Util.shared.currentUser.poster_avatar)
        let user = Util.shared.currentUser
        self.fullName.text = user.username
        self.birthday.text = user.birthday.FromStringToDateToString()
        if self.birthday.text?.count != 0 {
            self.dateSelect = (self.birthday.text?.FromStringToDateToDate())! 
        }
        self.city.text = user.city_name
        self.phone.text = user.poster_phone
        self.address.text = user.poster_address
    }
    
    deinit {
        print("and")
    }
    
    // MARK: - config Controller
    func settingConfig()
    {
        self.datePicker.delegate = self
        self.pickerView.delegate = self
    }
    
    // MARK: - UIAction
    @IBAction func cancelButtonDidTap(_ sender: Any) {
        self.popToView()
    }
    
    @IBAction func updateButtonDidTap(_ sender: Any) {
        self.userModel.username = self.fullName.text!
        self.userModel.poster_phone = self.phone.text!
        self.userModel.poster_address = self.address.text!
        self.showHUD("")
        APIClient.shared.updateUserInfor(userInfor: self.userModel, pass: self.newPass.text!).asObservable().bind(onNext: {result in
            self.showAlert("Cập nhật thông tin thành công")
            self.hideHUD()
            Util.shared.currentUser = self.userModel
        }).disposed(by: disposeBag)
    }
    
    @IBAction func birthdayButtonDidTap(_ sender: Any) {
       self.datePicker.config.startDate = self.dateSelect
       self.datePicker.show(inVC: SaveCurrentVC.shared.inforUserVC)
    }
    
    @IBAction func cityButtonDidTap(_ sender: Any) {
        self.pickerView.listData = self.listPickerCity
        self.pickerView.index = self.index
        self.pickerView.show(inVC: SaveCurrentVC.shared.inforUserVC)
    }
}

extension EditInforUserViewController:MIDatePickerDelegate
{
    func miDatePickerDidCancelSelection(_ amDatePicker: MIDatePicker) {
        
    }
    func miDatePicker(_ amDatePicker: MIDatePicker, didSelect date: Date) {
        self.birthday.text = date.dateFormatString(formater: "yyyy-MM-dd")
        self.dateSelect = date
        self.userModel.birthday = date.dateFormatString(formater: "yyyy-MM-dd HH:mm:ss")
    }
}

extension EditInforUserViewController:PickerViewDelegate
{
    func selectPickerView(_ Ppicker: PickerView, didSelect picker: ModelPicker, index: Int) {
        
    }
    
    func miPickerViewDidCancelSelection(_ amPicker: PickerView) {
        
    }
    
    func miPickerView(_ amPicker: PickerView, didSelect picker: ModelPicker) {
        self.city.text = picker.name
        self.index = picker.index
        self.userModel.city_id = "\(picker.id)"
        self.userModel.city_name = picker.name
        
    }
}
