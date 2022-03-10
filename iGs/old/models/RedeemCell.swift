//
//  PawnCell.swift
//  GoldSavingSTD-ios
//
//  Created by  Quark301 on 19/2/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import UIKit

class RedeemCell: UITableViewCell {

    
    
    
    @IBOutlet weak var refnum:UILabel!
    @IBOutlet weak var sumdescription:UILabel!
    @IBOutlet weak var outdate:UILabel!
    @IBOutlet weak var amountreceive:UILabel!
    @IBOutlet weak var sumitemwt:UILabel!
    @IBOutlet weak var amountget:UILabel!
    @IBOutlet weak var intCalculate:UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

    
    func bindView(_ data: RedeemDto ) {
        refnum.text = data.refnum
        sumdescription.text = data.sumdescription
        outdate.text = data.outdate?.asShortDateFormat()
        amountreceive.text = (data.amountreceive?.toString() ?? "-") + " บาท"
        sumitemwt.text = (data.sumitemwt?.toString() ?? "-") + " กรัม"
        amountget.text = (data.amountget?.toString() ?? "-") + " บาท"
        intCalculate.text = (data.intCalculate?.toString() ?? "-") + " บาท"
    }
}
