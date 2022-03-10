//
//  TestViewController.swift
//  GoldSavingSTD-ios
//
//  Created by  Quark301 on 19/12/2562 BE.
//  Copyright © 2562  Quark301. All rights reserved.
//

import UIKit

class RegisterSuccess: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    @IBAction func btFacebook_click(_ sender: Any) {
        guard let url = URL(string: (appContext?.facebook)!) else  { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)

    }
    @IBAction func btDial_click(_ sender: Any) {
        
        let telUrl = "tel://" + (appContext?.tel?.removeNonNumber() ?? "")
        guard let url = NSURL(string: telUrl) else  { return }
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func btGotoLogin_click(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "login") else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
