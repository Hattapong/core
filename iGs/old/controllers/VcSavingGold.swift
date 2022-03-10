//
//  sbSavingGoldVC.swift
//  GoldSavingSTD-ios
//
//  Created by  Quark301 on 22/11/2562 BE.
//  Copyright © 2562  Quark301. All rights reserved.
//

import UIKit
import Alamofire


class VcSavingGold: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var bankName: UITextField!
    @IBOutlet weak var bankAccountId: UITextField!
    @IBOutlet weak var amount: UITextField!
    
    @IBOutlet weak var btSave: RoundedUIButton!
    @IBOutlet weak var btSelectBranch: RoundedUIButton!
    @IBOutlet weak var uploadDescription: UILabel!
    @IBOutlet weak var modeDescription: UILabel!
    @IBOutlet weak var modeSwitch: UISwitch!
    
    @IBOutlet weak var btSelectContracId: RoundedUIButton!
    
    var slipImage: UIImage? = nil
    
    
    let bracnhSelecter = BranchSelecter()
    let contractSelecter = ContractSelecter()
    
    var branch:BranchBank? = nil {
        didSet {
            guard let b = branch else {
                btSelectBranch.setTitle("เลือกสาขาที่ต้องการ", for: .normal)
                bankName.text = ""
                bankAccountId.text = ""
                return
            }
            
            btSelectBranch.setTitle(b.branchname ?? "error", for: .normal)
            bankName.text = b.bankname
            bankAccountId.text = b.bankid
        }
    }
    var contract: ContractData? = nil {
        didSet {
            guard let c  = contract else {
                btSelectContracId.setTitle("เลือกบัญชีออมทอง", for: .normal)
                return
            }
            
            btSelectContracId.setTitle(c.contractid, for: .normal)
            fetchBranchForContract(with: c.branchname ?? "")
        }
    }
    
    var mode: SavingMode = .byBranch {
        didSet{
            branch = nil
            
            switch mode {
            case .byBranch:
                contract = nil
                btSelectContracId.isHidden = true
                modeDescription.text = "ออมแบบไม่เปิดบัญชี"
                btSelectBranch.isEnabled = true
                break
            case .byContractID:
                btSelectContracId.isHidden = false
                modeDescription.text = "ออมแบบเปิดบัญชี"
                btSelectBranch.isEnabled = false
                btSelectBranch.setTitle("", for: .normal)
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        initView()
        
        bracnhSelecter.selectCallback = {
            branch in
            self.branch = branch
        }
        
        contractSelecter.selectCallback = {
            contractData in
            self.contract = contractData
        }
    }
    
    @IBAction func handleCopy(_ sender: Any) {
        if let id = branch?.bankid {
            UIPasteboard.general.string = id
            alertCopySuccess()
        }
    }
    
    
    func alertCopySuccess() {
        let alert = UIAlertController(title: "ผลการทำงาน", message: "คัดลอกเลขที่บัญชีแล้ว", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "ตกลง", style: .default) { (act) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func onSelectImage(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        
        self.present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
            let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? NSURL  else {return}
        
        slipImage = selectedImage
        uploadDescription.text = imageURL.absoluteURL?.absoluteString
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onSave(_ sender: Any) {
        
        uploadData()
        
    }
    
    func initView() {
        
    }
    
    @IBAction func modeChanged(_ sender: Any) {
        mode = modeSwitch.isOn ? .byContractID : .byBranch
    }
    
    @IBAction func btSelectContract_click(_ sender: Any) {
        contractSelecter.show()
    }
    
    func fetchBranchForContract(with branchname:String){
        let router = Router.branchsBank(branchname: branchname)
        AF.request(router).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                do {
                    //here dataResponse received from a network request
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode([BranchBank].self, from:
                        response.data!) //Decode JSON Response Data
                    
                    if decodedData.count == 0 {
                        self.branch = nil
                    }
                    else {
                        self.branch = decodedData[0]
                    }
                    
                } catch let parsingError {
                    print("Error", parsingError)
                }            case .failure(let error):
                    print(error)
            }
        }
    }
    
    func uploadData() {
        
        guard isDataValid() else {
            return
        }
        
        guard let imageData = slipImage?.jpegData(compressionQuality: 1) else {
            showMsg(title: "โปรดเลือกรูป", cancleTitle: "ตกลง", false, completion: nil)
            return
        }
        
        let _bankId:String = bankAccountId.text ?? ""
        let amtText:String = amount.text ?? ""
        let _amt:Double = Double(amtText) ?? 0
        let _bankName:String = bankName.text ?? ""
        
        
        
        btSave.isEnabled = false
        let router = Router.addGoldSaving
        AF.upload(multipartFormData: { (multipartFormData) in
            
            
            
            let data = DataForSavingGold(savingAmt: _amt, bankId: _bankId, bankName: _bankName, paydate: nowStr, branchname: self.branch?.branchname, contractid: self.contract?.contractid)
            let encoder = JSONEncoder()
            let jsonData = try! encoder.encode(data)
            multipartFormData.append(jsonData, withName: "text")
            multipartFormData.append(imageData, withName: "image", fileName: "upload.jpeg", mimeType: "image/jpeg")
            
        }, with: router).validate().response { (response) in
            
            switch response.result {
            case .failure(let _err):
                self.showMsg(title: _err.errorDescription ?? "unknow error.", cancleTitle: "ลองใหม่",false,completion: nil)
            case .success(_):
                self.showMsg(title: "ส่งข้อมูลแล้ว โปรดรอการอนุมัติ", cancleTitle: "กลับหน้าหลัก",true,completion: nil)
                
                
            }
            
            self.btSave.isEnabled = true
        }
    }
    
    func isDataValid() -> Bool {
        
        if mode == .byContractID && contract == nil {
            showMsg(title: "โปรดเลือกบัญชี", cancleTitle: "ตกลง", false, completion: nil)
            return false
        }
        
        guard branch != nil else {
            showMsg(title: "โปรดระบุสาขา", cancleTitle: "ตกลง", false, completion: nil)
            return false
        }
        
        guard bankName.text != "" && bankAccountId.text != "" && amount.text != "" else {
            showMsg(title: "โปรดใส่ข้อมูลให้ครบ", cancleTitle: "ตกลง", false, completion: nil)
            return false
        }
        
        guard (slipImage != nil) else {
            showMsg(title: "โปรดเลือกรูป", cancleTitle: "ตกลง", false, completion: nil)
            return false
        }
        
        return true
    }
    
    
    @IBAction func handleSelectBranch(_ sender: Any) {
        bracnhSelecter.show()
    }
    
    func showMsg(title:String,cancleTitle:String,_ endProcess:Bool,completion:(()->Void)?) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancleTitle, style: UIAlertAction.Style.cancel, handler: { (action) in
            if endProcess {
                self.navigationController?.popViewController(animated: true)
            } else {
                alert.dismiss(animated: true, completion: nil)
            }
            
        }))
        
        self.present(alert, animated: true, completion: completion)
    }
}


