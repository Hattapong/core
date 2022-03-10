//
//  PendingDetailView.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 26/10/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import UIKit


class PendingDetailView : CustomView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var billnum: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var status: UILabel!
    
    
    var data: PendingSavingDto? {
        didSet {
            guard let data = data else {
                billnum.text = "-"
                date.text = "-"
                amount.text = "-"
                status.text = "-"
                return
            }
            
            billnum.text = data.id.toString()
            date.text = data.paydate.asShortDateFormat()
            amount.text = data.savingAmt.toString()
            
            status.text = data.approved == nil ? "รออนุมัติ" : "ยกเลิก"
            status.textColor = data.approved == nil ? #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1) : #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }
    }
    override func commonInit(){
        
        loadNib(String(describing: PendingDetailView.self))
        addEmbedView(contentView: contentView)
        
    }
}
