//
//  sbRegisterVC.swift
//  GoldSavingSTD-ios
//
//  Created by  Quark301 on 2/12/2562 BE.
//  Copyright © 2562  Quark301. All rights reserved.
//

import UIKit
import Alamofire

class sbRegisterVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var slipImage: UIImage? = nil
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtThaiId: UITextField!
    
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtAmphur: UITextField!
    @IBOutlet weak var txtProvince: UITextField!
    @IBOutlet weak var txtZipCode: UITextField!
    @IBOutlet weak var txtTel: UITextField!
    @IBOutlet weak var txtAmount: UITextField!
    
    @IBOutlet weak var btSave: RoundedUIButton!
    
    @IBOutlet weak var dataScrollView: UIScrollView!
    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var uploadDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        txtFirstName.delegate = self
        txtLastName.delegate = self
        txtThaiId.delegate = self
        txtAddress.delegate = self
        txtAmphur.delegate = self
        txtProvince.delegate = self
        txtZipCode.delegate = self
        txtTel.delegate = self
        txtAmount.delegate = self
        dataScrollView.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
            let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? NSURL  else {return}
        
        slipImage = selectedImage
        uploadDescription.text = imageURL.absoluteURL?.absoluteString
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func btSelectImg_click(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        
        self.present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func btBack_click(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btSave_click(_ sender: Any) {
        register()
    }
    
    func register() {
        guard isValidInput() else { return }
        
        guard let imageData = slipImage?.jpegData(compressionQuality: 1) else {
            showLegacyToastShort(message: "โปรดเลือกรูป")
            return
        }
        
        btSave.isEnabled = false
        var input: InputRegister = InputRegister()
        input.custname = txtFirstName.text! + " " + txtLastName.text!
        input.address = txtAddress.text!
        input.amphur = txtAmphur.text!
        input.province = txtProvince.text!
        input.thaiid = txtThaiId.text!
        input.phone = txtTel.text!
        input.zipcode = txtZipCode.text!
        input.savingAmt = Double(txtAmount.text!)
        input.bankName = appContext?.bankAccount?.bank
        input.bankID = appContext?.bankAccount?.accountNumber
        input.paydate = nowStr
        
        let router = Router.register(input: input)
        AF.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(imageData, withName: "image", fileName: "upload.jpeg", mimeType: "image/jpeg")
            
        }, with: router).validate().response { (response) in
            
            switch response.result {
            case .failure(let _err):
                self.showFailMsg(message: _err.errorDescription ?? "unknow error.")
                print(_err)
                
                
                
            case .success(_):
                self.showSuccessMsg()
                
            }
            
            self.btSave.isEnabled = true
        }
    }
    
    func isValidInput() -> Bool {
        
        guard isImageSelected() else { return false }
        guard isFirstNameValid() else { return false }
        guard isLastNameValid() else { return false }
        //guard isThaiidValid() else { return false }
        //guard isAddressValid() else { return false }
        //guard isAmphurValid() else { return false }
        //guard isProvinceValid() else { return false }
        //guard isZipCodeValid() else { return false }
        guard isTelValid() else { return false }
        guard isAmountValid() else { return false }
        return true
    }
    
    func isImageSelected() -> Bool {
        guard slipImage != nil else {
            showLegacyToastShort(message: "โปรดเลือกรูปสลิป")
            return false
        }
        
        return true
    }
    func isFirstNameValid() -> Bool {
        
        guard txtFirstName.text!.count > 0 else {
            showLegacyToastShort(message: "โปรดใส่ชื่อ")
            return false
        }
        
        return true
    }
    func isLastNameValid() -> Bool {
        
        guard txtLastName.text!.count > 0 else {
            showLegacyToastShort(message: "โปรดใส่นามสกุล")
            return false
        }
        
        return true
    }
    func isThaiidValid() -> Bool {
        
        guard txtThaiId.text!.isThaiId() else {
            showLegacyToastShort(message: "โปรดระบุรหัสบัตรประชาชน 13 หลักให้ถูกต้อง")
            return false
        }
        
        return true
    }
    func isAddressValid() -> Bool {
        
        guard txtAddress.text!.count > 0 else {
            showLegacyToastShort(message: "โปรดระบุที่อยู่")
            return false
        }
        
        return true
    }
    func isAmphurValid() -> Bool {
        
        guard txtAmphur.text!.count > 0 else {
            showLegacyToastShort(message: "โปรดระบุอำเภอ")
            return false
        }
        
        return true
    }
    func isProvinceValid() -> Bool {
        
        guard txtProvince.text!.count > 0 else {
            showLegacyToastShort(message: "โปรดระบุจังหวัด")
            return false
        }
        
        return true
    }
    func isZipCodeValid() -> Bool {
        
        guard txtZipCode.text!.isIsZipCode() else {
            showLegacyToastShort(message: "โปรดระบุรหัสไปรษณีย์")
            return false
        }
        
        return true
    }
    func isTelValid() -> Bool {
        
        guard txtTel.text!.count > 0 else {
            showLegacyToastShort(message: "โปรดระบุเบอร์โทรศัพท์")
            return false
        }
        
        return true
    }
    func isAmountValid() -> Bool {
        
        guard txtAmount.text!.count > 0 && (txtAmount.text?.isNumber())! else {
            showLegacyToastShort(message: "โปรดระบุจำนวนเงิน")
            return false
        }
        
        return true
    }
    
    func showSuccessMsg() {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "registerSuccess") else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
        
        
    }
    func showFailMsg(message: String) {
        let alert = UIAlertController(title: "สมัครสมาชิกไม่สำเร็จ !", message: message,
                                      preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "ตกลง", style: .default ) {
            action in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
}
extension sbRegisterVC : UITextFieldDelegate {
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.tag == 509 {
            register()
            return false
        }
        
        let nextTag = textField.tag + 1
        // Try to find next responder
        let nextResponder = view?.viewWithTag(nextTag) as UIResponder?
        
        if nextResponder != nil {
            // Found next responder, so set it
            nextResponder?.becomeFirstResponder()
            self.dataScrollView.scrollToView(view: nextResponder as! UIView, animated: true, constance: 50)
        } else {
            // Not found, so remove keyboard
            textField.resignFirstResponder()
        }
        
        return false
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if  501...509 ~= textField.tag{
            self.dataScrollView.scrollToView(view: textField , animated: true, constance: 50)
        }
    }
}


extension sbRegisterVC : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let limitLower = 16.0
        let limitUpper = 40.0
        let y = scrollView.contentOffset.y
        
        if limitLower...limitUpper ~= Double((96 - y) / 2) {
            let newFont = self.titleLab.font.withSize((96 - y) / 2)
            self.titleLab.font = newFont
        }
    }
    
}
