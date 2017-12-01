//
//  EditInforUserViewController.swift
//  BDS
//
//  Created by Duy Huy on 11/30/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit

class EditInforUserViewController: UITableViewController {
    //MARK: - Outlet
    @IBOutlet weak var avatarUser: UIImageView!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var birthday: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var oldPass: UITextField!
    @IBOutlet weak var newPass: UITextField!
    @IBOutlet weak var enterPass: UITextField!
    
    var datePicker = MIDatePicker.getFromNib()
    var pickerView = PickerView.getFromNib()
    var listPicker:[ModelPicker] = [ModelPicker(id: 0, name: "Hà Nội"),ModelPicker(id: 2, name: "Thanh Hoá"),ModelPicker(id: 3, name: "Nam Định")]
    var index:Int = 0
    var dateSelect:Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    }
    
    @IBAction func updateButtonDidTap(_ sender: Any) {
    }
    
    @IBAction func birthdayButtonDidTap(_ sender: Any) {
       self.datePicker.config.startDate = self.dateSelect
       self.datePicker.show(inVC: SaveCurrentVC.shared.inforUserVC)
    }
    
    @IBAction func cityButtonDidTap(_ sender: Any) {
        self.pickerView.listData = self.listPicker
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
    }
}

extension EditInforUserViewController:PickerViewDelegate
{
    func miPickerViewDidCancelSelection(_ amPicker: PickerView) {
        
    }
    
    func miPickerView(_ amPicker: PickerView, didSelect picker: ModelPicker) {
        self.city.text = picker.name
        self.index = picker.index
    }
}
