//
//  popupDialogHelper.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 8/9/2564 BE.
//  Copyright © 2564 BE  Thongkaset. All rights reserved.
//

import UIKit

import PopupDialog


extension UIViewController {
    
    func prompt(title:String, message:String, cancel: (()->Void)?, ok:(()->Void)? ) {
        
        let popup = PopupDialog(title: title, message: message)
        let font = UIFont(name: kFFPrimary, size: 24)!
        
        
        let okButton = DefaultButton(title: "ตกลง") {
            if let ok = ok { ok() }
            
        }
        
        okButton.titleFont = font
        okButton.titleColor = kColorPrimary
        
        
        let cancelButton = CancelButton(title: "ยกเลิก") {
            if let cancel = cancel { cancel() }
        }
        cancelButton.titleFont = font
        
        popup.addButtons([okButton, cancelButton])
     
        
        popup.transitionStyle = .fadeIn
        
        let vc = popup.viewController as! PopupDialogDefaultViewController
        vc.titleColor = .black
        vc.messageColor = .black
        vc.titleFont = font
        vc.messageFont = font
        
        self.present(popup, animated: true, completion: nil)
    }
    
}

