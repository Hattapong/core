

import UIKit
import Alamofire
import PopupDialog


/// content หน้าออมทอง
class SavingGoldView : CustomView {
    @IBOutlet weak var contentView: UIView!
    
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
    
    
    override func commonInit(){
        
        loadNib(String(describing: SavingGoldView.self))
        addEmbedView(contentView: contentView)
        
      
        bracnhSelecter.selectCallback = {
            branch in
            self.branch = branch
        }
        
        contractSelecter.selectCallback = {
            contractData in
            self.contract = contractData
        }
    }
    
    @IBAction func modeChanged(_ sender: Any) {
        mode = modeSwitch.isOn ? .byContractID : .byBranch
    }
    
    @IBAction func btSelectContract_click(_ sender: Any) {
        contractSelecter.show()
    }
    
    
    @IBAction func handleSelectBranch(_ sender: Any) {
        bracnhSelecter.show()
    }
    
    @IBAction func handleImageSelect(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        
        self.parentViewController?.present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func handleBankAcctNoCopy(_ sender: UIButton) {
        if let accountNo = self.branch?.bankid{
            UIPasteboard.general.string = accountNo
            self.toast(message: "คัดลอกแล้ว!")
        }
        
    }
    
    @IBAction func handleSave(_ sender: Any) {
        
        uploadData()
        
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
              //showMsg(title: "โปรดเลือกรูป", cancleTitle: "ตกลง", false, completion: nil)
               return
           }
           
           let _bankId:String = bankAccountId.text ?? ""
           let amtText:String = amount.text ?? ""
           let _amt:Double = Double(amtText) ?? 0
           let _bankName:String = bankName.text ?? ""
           
           
           
           btSave.isEnabled = false
           let router = Router.addGoldSaving
           AF.upload(multipartFormData: { (formData) in
               
               
               let data = DataForSavingGold(savingAmt: _amt, bankId: _bankId, bankName: _bankName, paydate: nowStr, branchname: self.branch?.branchname, contractid: self.contract?.contractid)
               
               let encoder = JSONEncoder()
               let jsonData = try! encoder.encode(data)
               
               formData.append(jsonData, withName: "text")
               formData.append(imageData, withName: "image", fileName: "upload.png", mimeType: "image/png")
               
               
           }, with: router).validate().response { (response) in
               
               switch response.result {
               case .failure( _):
                self.alertError(message: "ทำรายการไม่สำเร็จ ลองทำรายการอีกครั้งหรือติดต่อสอบถามทางร้าน")
                break
               case .success(_):
                self.alertSuccess()
                   break
                   
               }
               
               self.btSave.isEnabled = true
           }
       }
       
    func isDataValid() -> Bool {
        
        if mode == .byContractID && contract == nil {
            toast(message: "ต้องระบุเลขที่สัญญาออมทอง")
            return false
        }
        
        guard branch != nil else {
            toast(message: "ต้องระบุสาขา")
            return false
        }
        
        guard bankName.text != "" && bankAccountId.text != "" && amount.text != "" else {
            toast(message: "ใส่ข้อมูลไม่ครบ")
            return false
        }
        
        guard (slipImage != nil) else {
            toast(message: "ไม่ได้เลือกรูปภาพ")
            return false
        }
        
        return true
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
    
    
       
}


extension SavingGoldView : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
