//
//  InterestCellDetail.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 27/10/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import UIKit


class InterestCellDetail : CustomView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var billnum: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var baseAmount: UILabel!
    @IBOutlet weak var intAmount: UILabel!
    
    
    var data: InterestDto? {
        didSet {
            guard let data = data else {
                billnum.text = "-"
                date.text = "-"
                baseAmount.text = "-"
                intAmount.text = "-"
                return
            }
            
             
            billnum.text = data.refnum
            date.text = data.trandate?.asShortDateFormat()
            baseAmount.text = data.amountget?.toString()
            intAmount.text = data.amountreceive?.toString()
            
        }
    }
    override func commonInit(){
        
        loadNib(String(describing: InterestCellDetail.self))
        addEmbedView(contentView: contentView)
        
    }
    
}
