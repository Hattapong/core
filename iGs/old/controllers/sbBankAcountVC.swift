//
//  sbBankAcountVC.swift
//  GoldSavingSTD-ios
//
//  Created by  Quark301 on 2/12/2562 BE.
//  Copyright © 2562  Quark301. All rights reserved.
//

import UIKit

class sbBankAcountVC: UIViewController {

    @IBOutlet weak var txtBankAccount: UILabel!
    @IBOutlet weak var txtBankAccountName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let app = appContext else { return }
        
        txtBankAccount.text = app.bankAccount?.accountNumber
        txtBankAccountName.text = app.bankAccount?.bank
    }
    
    @IBAction func btCopy_click(_ sender: Any) {
        guard let accountNumber = txtBankAccount.text else { return }
        
        UIPasteboard.general.string = accountNumber
        
        alertCopySuccess()
    }
    
    func alertCopySuccess() {
        let alert = UIAlertController(title: "ผลการทำงาน", message: "คัดลอกเลขที่บัญชีแล้ว", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "ตกลง", style: .default) { (act) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }

    @IBAction func btRegister_click(_ sender: Any) {
        openRegisterPage()
    }
    
    func openRegisterPage(){
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "register") else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btBack_click(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
