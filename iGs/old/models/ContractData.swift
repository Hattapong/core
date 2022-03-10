//
//  ContractData.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 2/7/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import Foundation


class ContractData: Codable {
    init(branchname: String? = nil, contractid: String? = nil, custid: String? = nil) {
        self.branchname = branchname
        self.contractid = contractid
        self.custid = custid
    }
    
    var branchname: String?
    var contractid: String?
    var custid: String?
}
