//
//  SummaryView.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 26/10/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import UIKit

class SummaryView: CustomView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var sumTotal: UILabel!
    @IBOutlet weak var sumAmount: UILabel!
    
    
    override func commonInit(){
        
        loadNib(String(describing: SummaryView.self))
        addEmbedView(contentView: contentView)
        
    }
    
}
