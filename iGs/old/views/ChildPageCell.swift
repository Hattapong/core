//
//  ChildPageCell.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 22/10/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import UIKit

class ChildPageCell: UICollectionViewCell {
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView(v: UIView){
        contentView.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        
        contentView.addSubview(v)
        v.frame = contentView.frame
    }
    
    
}
