//
//  GoldSavingDetailView.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 26/10/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import UIKit

class GoldSavingDetailView: CustomView {
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var billnum: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var status: UILabel!
    
    var data: GoldSavingDto? {
        didSet {
            guard let data = data else {
                billnum.text = "-"
                date.text = "-"
                amount.text = "-"
                status.text = "-"
                return
            }
            
            billnum.text = data.billnum
            date.text = data.billdate.asShortDateFormat()
            amount.text = data.savingAmt.toString()
            status.text = data.approved
            status.textColor = data.approved == "อนุมัติแล้ว" ? #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1) : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            
        }
    }
    
    override func commonInit(){
        
        loadNib(String(describing: GoldSavingDetailView.self))
        addEmbedView(contentView: contentView)
        
    }
    
}
