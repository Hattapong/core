//
//  WiatApproveCell.swift
//  GoldSavingSTD-ios
//
//  Created by  Quark301 on 22/11/2562 BE.
//  Copyright © 2562  Quark301. All rights reserved.
//

import UIKit

class WaitApproveCell: UITableViewCell {

    
    @IBOutlet weak var payDate: UILabel!
    @IBOutlet weak var savingAmt: UILabel!
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var status: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
