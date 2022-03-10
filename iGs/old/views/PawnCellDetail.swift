//
//  PawnCellDetail.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 27/10/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import UIKit


class PawnCellDetail : CustomView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var billnum: UILabel!
    @IBOutlet weak var beginDate: UILabel!
    @IBOutlet weak var baseAmount: UILabel!
    @IBOutlet weak var dueDate: UILabel!
    @IBOutlet weak var itemsSummary: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var branchname: UILabel!
    
    
    var data: PawnDto? {
        didSet {
            guard let data = data else {
                return
            }
            
            billnum.text = data.pawnid
            beginDate.text = (data.indate?.asShortDateFormat() ?? "-")
            baseAmount.text = (data.amountget?.toString() ?? "-") + " บาท"
            dueDate.text = (data.duedate?.asShortDateFormat() ?? "-")
            
            itemsSummary.text = data.sumdescription
            weight.text = (data.sumitemwt?.toString() ?? "-") + " กรัม"
            branchname.text = data.branchname
            
            //amountget.text = (data.amountget?.toString() ?? "-") + " บาท"
            
        }
    }
    override func commonInit(){
        
        loadNib(String(describing: PawnCellDetail.self))
        addEmbedView(contentView: contentView)
        
    }
}
