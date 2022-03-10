//
//  InterestForm.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 27/10/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import UIKit
import Alamofire
import ProgressHUD
import PopupDialog

class InterestFormVC : VCBase {
    
    let rootView = InterestForm()
    
    
    var data: PawnDto? = nil {
        didSet {
            guard let data = data else { return }
            rootView.item = data
            setTitleText(text:"ต่อดอกเลขที่ \(data.pawnid!)")
        }
    }
    
    
    override func setupView() {
        super.setupView()
        rootView.parent = self
        addRootView(v: rootView)
        
    }
    
    
}

class InterestForm: CustomView {
    
    var parent: UIViewController?
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var txtInitialAmt: UILabel!
    
    @IBOutlet weak var txtMonth: UILabel!
    @IBOutlet weak var txtDateBegin: UILabel!
    
    @IBOutlet weak var txtDateEnd: UILabel!
    
    @IBOutlet weak var txtAmount: UILabel!
    @IBOutlet weak var txtAccountNo: UILabel!
    @IBOutlet weak var txtBankName: UILabel!
    
    var slipImage: UIImage? = nil
    
    
    @IBOutlet weak var btSave: RoundedUIButton!
    @IBOutlet weak var uploadDescription: UILabel!
    
    @IBOutlet weak var monthAmt: UIStepper!
    
    var item: PawnDto? = nil {
        didSet {
            if let branchname = item?.branchname {
                self.fetchData()
                self.fetchBranchBank(with: branchname)
            }
        }
    }
    var branchBank: BranchBank? = nil {
        didSet {
            if let bank  = branchBank {
                txtBankName.text = bank.bankname
                txtAccountNo.text = bank.bankid
            }
        }
    }
    
    var dateBegin: Date? {
        didSet {
            guard dateBegin != nil else { return }
            txtDateBegin.text = dateBegin?.toString(withFormat: "d MMM yyyy")
        }
    }
    var dateEnd: Date?{
        didSet {
            guard dateEnd != nil else {
                txtDateEnd.text = "เลือกจำนวนเดือน"
                return
            }
            txtDateEnd.text = (dateEnd?.toString(withFormat: "d MMM yyyy"))!
        }
    }
    
    var interestForShow: InterestForShow? = nil {
        didSet {
            guard let dataForShow = interestForShow else { return }
            
            txtMonth.text = "0"
            txtInitialAmt.text = dataForShow.amountGet?.toString()
            dateBegin = parseAPIDate(interestForShow!.fromDate!)
            
        }
    }
    var amountPay: Double = 0 {
        didSet {
            if (amountPay == 0) {
                txtAmount.text = "เลือกจำนวนเดือน"
            }
            else {
                txtAmount.text =  amountPay.toString() + " บาท"
            }
        }
    }
    
    
    override func commonInit(){
        
        loadNib(String(describing: type(of: self)))
        addEmbedView(contentView: contentView)
        initialState()
       
    }
    
    // MARK: -  initailize view state
    func initialState(){
        txtInitialAmt.text = "0"
        txtMonth.text = "0"
        
        txtDateBegin.text = "เลือกจำนวนเดือน"
        txtDateEnd.text = "เลือกจำนวนเดือน"
        txtAmount.text = "เลือกจำนวนเดือน"
        txtAccountNo.text = "เลือกจำนวนเดือน"
        txtBankName.text = "เลือกจำนวนเดือน"

    }
    
    
    // MARK: -  Fetch Bank of Branch
    func fetchBranchBank(with branchname:String){
        let router = Router.branchsBank(branchname: branchname)
        AF.request(router).validate()
            .responseDecodable(of: [BranchBank].self) { res in
                switch res.result {
                    case .success(let bob):
                    
                        if bob.isEmpty {
                            ProgressHUD.showFailed("สาขานี้ไม่สามารถทำรายการได้", interaction: false)
                            self.parentViewController?.dismiss(animated: false)
                        }
                        else {
                            self.branchBank = bob[0]
                        }
                    
                    case .failure(let error):
                    print(error.localizedDescription)
                    ProgressHUD.showFailed("สาขานี้ไม่สามารถทำรายการได้", interaction: false)
                    self.parentViewController?.dismiss(animated: false)
                }
                
            }
        
        
    }
    
    func fetchData() {
        guard let pawnid = item?.pawnid else { return }
        
        let route = Router.getPawnForShow(pawnId: pawnid)
        AF.request(route).validate().response { (response) in
            switch response.result {
                
            case .success(let jsonData):
                self.interestForShow = parseData(data: jsonData!)
                //print(String(data: response.data!, encoding: String.Encoding.utf8)!)
            case .failure(let _err):
                print(_err.errorDescription ?? "_error__")
            }
            
        }
    }
    
    @IBAction func handleStepperChange(_ sender: Any) {
        let value = (sender as! UIStepper).value
        txtMonth.text = value.toString()
        guard interestForShow != nil && dateBegin != nil else { return }
        
        if value == 0 {
            dateEnd = nil
            amountPay = 0
            
        } else {
            dateEnd = Calendar.current.date(byAdding: .month, value: Int(value), to: dateBegin!)
            
            amountPay = ((interestForShow!.amountGet! * interestForShow!.intrate!) / 100) * value
            
        }
    }
    
    @IBAction func handleSelectImage(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        
        parent?.present(pickerController, animated: true, completion: nil)
    }
    @IBAction func handleBankAcctNoCopy(_ sender: UIButton) {
        if let accountNo = self.branchBank?.bankid {
            UIPasteboard.general.string = accountNo
            self.toast(message: "คัดลอกแล้ว!")
        }
        
    }
    
    @IBAction func handleSubmit(_ sender: Any) {
        guard let item = item else { return }
        guard validateData() else { return }
        
        let dto = InterestForAddDto()
        dto.amountget = interestForShow?.amountGet
        dto.amountpay = amountPay
        dto.bankid = branchBank?.bankid
        dto.bankname = branchBank?.bankname
        dto.duedate = dateEnd?.toString(withFormat: "yyyy-MM-dd", calendarIdentifier: .gregorian)
        dto.intrate = interestForShow?.intrate
        dto.months = monthAmt.value
        dto.pawnid = item.pawnid
        dto.branchname = item.branchname
        
        
        guard let imageData = slipImage?.pngData() else {
            return
        }
        
        btSave.isEnabled = false
        let router = Router.addInterest
        AF.upload(multipartFormData: { (multipartFormData) in
            
            let encoder = JSONEncoder()
            let jsonData = try! encoder.encode(dto)
            multipartFormData.append(jsonData, withName: "text")
            multipartFormData.append(imageData, withName: "image", fileName: "upload.png", mimeType: "image/png")
            
        }, with: router).validate().response { (response) in
           
            switch response.result {
            case .failure(let error):
                
                print(error.localizedDescription)
                
                if let erData = response.data,
                    let erDetail = String(data: erData, encoding: String.Encoding.utf8) {
                    print(erDetail)
                }
                
                self.alertError(message: "ทำรายการไม่สำเร็จ ลองทำรายการอีกครั้งหรือติดต่อสอบถามทางร้าน")
                
            case .success(_):
                
                self.alertSuccess()
                
            }
            
            self.btSave.isEnabled = true
        }
    }
    
    func alertMessage(title: String, message: String, completion: (()-> Void)?){
        let popup = PopupDialog(title: title, message: message)
        
        let cancelButton = CancelButton(title: "ตกลง") {}
        cancelButton.titleFont = UIFont(name: "Trirong-ExtraLight", size: 18)!
        
        popup.addButtons([cancelButton])
        
        self.parentViewController?.present(popup, animated: true, completion: {
        })
        
        let vc = popup.viewController as! PopupDialogDefaultViewController
        vc.titleFont = UIFont(name: "Trirong", size: 18)!
        vc.messageFont = UIFont(name: "Trirong-ExtraLight", size: 18)!
        
    }
    
    func alertError(message: String) {
        alertMessage(title: "พบข้อผิดพลาด", message: message, completion: nil)
    }
    
    func alertSuccess(){
        
        let title = "ผลการทำรายการ"
        let msg = "ทำรายการสำเร็จแล้ว ตรวจสอบการอนุมัติได้ที่หน้าประวัติ"
        let popup = PopupDialog(title: title, message: msg, tapGestureDismissal: false, panGestureDismissal: false)
        
        
        let btn = DefaultButton(title: "ตกลง") {
            self.parentViewController?.dismiss(animated: true, completion: nil)
        }
        btn.titleFont = UIFont(name: "Trirong-ExtraLight", size: 18)!
        btn.titleColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        
        popup.addButtons([btn])
        
        self.parentViewController?.present(popup, animated: true, completion: {
            
        })
        
        let vc = popup.viewController as! PopupDialogDefaultViewController
        vc.titleFont = UIFont(name: "Trirong", size: 18)!
        vc.messageFont = UIFont(name: "Trirong-Light", size: 18)!
        
    }
    
    func validateData()-> Bool {
        
        if !(1...12 ~= monthAmt.value) {
            self.toast(message: "ยังไม่ได้เลือกจำนวนเดือน\n")
            return false
        }
        
        if slipImage == nil {
            self.toast(message: "ยังไม่ได้เลือกรูปสลิป/หลักฐานการชำระเงิน\n")
            return false
        }
        
        
       
        return true;
    }
    
}

extension InterestForm : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: -  Image Selected
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        guard
            let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
            let reducedImage = selectedImage.reduceFile(),
            let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? NSURL
        else {return}
        

        
        guard reducedImage.isAllow(limitMB: 2) else {
            let msg = "รูปที่เลือกขนาดใหญ่เกินไป (> 2MB)"
            self.toast(message: msg)
            picker.dismiss(animated: true, completion: nil)
            return
        }
        
        
        slipImage = reducedImage
        
        
        
        uploadDescription.text = imageURL.absoluteURL?.absoluteString
        picker.dismiss(animated: true, completion: nil)
    }
}
