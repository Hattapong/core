//
//  PawnDetailCell.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 8/6/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import UIKit

class PawnDetailCell: UITableViewCell {

    @IBOutlet weak var paydate: UILabel!
    @IBOutlet weak var amountpay: UILabel!
    
    
    override func awakeFromNib() { super.awakeFromNib() }

    
    func bindView(pawnDetail: PawnDetailForRow){
        
        paydate.text = pawnDetail.paydate?.asShortDateFormat()
        amountpay.text = pawnDetail.amountpay!.toString() + "฿"
        
    }

}
