//
//  AddGSModel.swift
//  GoldSavingSTD-ios
//
//  Created by  Quark301 on 29/10/2562 BE.
//  Copyright © 2562  Quark301. All rights reserved.
//

import Foundation
class DataForSavingGold : Codable {
    
    
    init(savingAmt: Double? = nil, bankId: String? = nil, bankName: String? = nil, paydate: String? = nil, branchname: String? = nil, contractid: String? = nil) {
        self.savingAmt = savingAmt
        self.bankId = bankId
        self.bankName = bankName
        self.paydate = paydate
        self.branchname = branchname
        self.contractid = contractid
    }
    

        var savingAmt : Double?
        var bankId : String?
        var bankName : String?
        var paydate : String?
        var branchname : String?
        var contractid: String?

}
