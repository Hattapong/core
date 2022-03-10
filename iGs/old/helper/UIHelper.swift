//
//  UIHelper.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 17/3/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import UIKit

extension UIViewController

{
    
   func alertAndDissmiss(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: {
            _ in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    func alertAndDissmiss(title: String, message: String, doAfterDismiss: @escaping ()-> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: {
            _ in
            alert.dismiss(animated: true, completion: doAfterDismiss)
        })
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    func delay(sec: DispatchTime, action: @escaping ()-> Void) {
        DispatchQueue.main.asyncAfter(deadline: sec, execute: action)
    }
    
}
