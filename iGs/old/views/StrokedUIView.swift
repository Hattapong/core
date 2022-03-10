//
//  StrokedUIView.swift
//  GoldSavingSTD-ios
//
//  Created by  Quark301 on 22/11/2562 BE.
//  Copyright © 2562  Quark301. All rights reserved.
//


import Foundation
import UIKit

@IBDesignable
class StrokeUIView: UIView {
    
    @IBInspectable var direction: Direction = .bottom {
        didSet {
            let v: UIView = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.heightAnchor.constraint(equalToConstant: 3.0).isActive = true
            v.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
            v.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
            v.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
            v.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            self.addSubview(v)
        }
    }
    
    
    @objc enum Direction: Int {
        case top
        case bottom
    }
}


