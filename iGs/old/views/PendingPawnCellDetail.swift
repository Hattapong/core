//
//  PendingPawnCellDetail.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 27/10/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import UIKit

class PendingPawnCellDetail : CustomView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var billnum: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var intAmount: UILabel!
    @IBOutlet weak var status: UILabel!
    
    
    var data: PendingPawnDto? {
        didSet {
            guard let data = data else { return }
            
             
            billnum.text = data.pawnid
            date.text = data.paydate?.asShortDateFormat()
            intAmount.text = data.amountpay?.toString()
        
            let statusText = data.checkPayStatus == nil ? "รออนุมัติ" : "ยกเลิก"
            status.text = statusText
            
        }
    }
    override func commonInit(){
        
        loadNib(String(describing: PendingPawnCellDetail.self))
        addEmbedView(contentView: contentView)
        
    }
    
}

