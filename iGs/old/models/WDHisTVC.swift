//
//  WDHisTVC.swift
//  GoldSavingSTD-ios
//
//  Created by  Quark301 on 28/10/2562 BE.
//  Copyright © 2562  Quark301. All rights reserved.
//

import UIKit

class WDHisTVC: UITableViewCell {

    @IBOutlet weak var billNum: UILabel!
    @IBOutlet weak var billDate: UILabel!
    @IBOutlet weak var widrawAmt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
