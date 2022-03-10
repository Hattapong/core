//
//  UIViewExtension.swift
//  iGS_SRV
//
//  Created by Hattapong on 7/9/2564 BE.
//


import UIKit



extension UIView {
    
    
    func round(color:UIColor = kColorPrimary, width:CGFloat = 1, radius:CGFloat = 10) {
        
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = radius
        
    }
    
     
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        endEditing(true)
    }
}
