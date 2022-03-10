//
//  RoundTextField.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 13/11/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import Foundation



import Foundation
import UIKit

@IBDesignable
class RoundTextField: UITextField {
    
    @IBInspectable var borderColor: UIColor = kColorPrimary {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
}
