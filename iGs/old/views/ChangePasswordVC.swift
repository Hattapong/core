//
//  ChangePasswordVC.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 28/10/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import UIKit
import Alamofire

class ChangePasswordVC: VCBase, ChangePasswordDelegate {
    

   
   
    var delegate: MenuDelegate?
    let root = ChangePasswordForm()
    
    override func setupView() {
       
        super.setupView()
        setTitleText(text: "เปลี่ยนรหัสผ่านผู้ใช้")
        root.delegate = self
        addRootView(v: root)
    }

    
    
    func dismissLogout(){
        if let delegate = delegate {
            self.dismiss(animated: true) {
                delegate.menuDidSelect(tag: .logout(prompting: false))
            }
            
        }
        
    }
    
    func didChanged() {
        let title = "ผลการทำรายการ"
        let message = "เปลี่ยนรหัสผ่านแล้ว กลับสู่หน้าล็อกอิน"
        forcePromptDialog(title: title, message: message) {
            self.dismissLogout()
        }
        1
    }
    
}


class ChangePasswordForm: CustomView {
    
    var delegate : ChangePasswordDelegate!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var txtOldPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    override func commonInit(){
    
    loadNib(String(describing: ChangePasswordForm.self))
    addEmbedView(contentView: contentView)
    }
    
    @IBAction func handleSubmit(_ sender: Any) {
        
        guard isInputValid() else {
            return
        }
        
        let route = Router.changePassword(_old: txtOldPassword.text!, _new: txtNewPassword.text!)
        AF.request(route).validate().response { (response) in
            switch response.result {
            case .success(_): self.handlePasswordChanged()
            case .failure(_):self.handleError()
            }
        }
        
    }
    
    func handlePasswordChanged(){
        delegate.didChanged()
    }
    
    func handleError(){
        toast(message: "ทำรายการไม่สำเร็จ")
    }
    
    func isInputValid()-> Bool {
        
        guard txtOldPassword.text != "" &&  txtNewPassword.text != "" &&  txtConfirmPassword.text != "" else {
            toast(message:"โปรดใส่ข้อมูลให้ครบ")
            return false
        }
        
        guard txtNewPassword.text == txtConfirmPassword.text  else {
            toast(message:"โปรดยืนยันรหัสผ่านใหม่ให้ตรงกัน")
            return false
        }
        
        guard txtNewPassword.text!.count >= 4 && txtConfirmPassword.text!.count >= 4  else {
            toast(message:"ความยาวรหัสผ่านใหม่ต้องไม่น้อยกว่า 4 ตัว")
            return false
        }
        
        return true
    }
}


protocol ChangePasswordDelegate {
    func didChanged()
}
