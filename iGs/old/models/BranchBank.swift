//
//  BranchBank.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 1/7/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import Foundation

class BranchBank : Codable {
    init(branchname: String? = nil, bankname: String? = nil, bankid: String? = nil) {
        self.branchname = branchname
        self.bankname = bankname
        self.bankid = bankid
    }
    
    var branchname : String?
    var bankname : String?
    var bankid : String?
}
