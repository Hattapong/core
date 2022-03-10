//
//  RoundedUIButton.swift
//  GoldSavingSTD-ios
//
//  Created by  Quark301 on 21/11/2562 BE.
//  Copyright © 2562  Quark301. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundedUIButton: UIButton {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
}
