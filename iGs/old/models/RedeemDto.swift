//
//  PawnDto.swift
//  GoldSavingSTD-ios
//
//  Created by  Quark301 on 19/2/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//


//
//   let redeemDto = try? newJSONDecoder().decode(RedeemDto.self, from: jsonData)

import Foundation

// MARK: - RedeemDto

class RedeemDto : Codable {
    var refnum, sumdescription, outdate: String?
    var amountreceive, sumitemwt, amountget, intCalculate: Double?

    init(refnum: String?, sumdescription: String?, outdate: String?, amountreceive: Double?, sumitemwt: Double?, amountget: Double?, intCalculate: Double?) {
        self.refnum = refnum
        self.sumdescription = sumdescription
        self.outdate = outdate
        self.amountreceive = amountreceive
        self.sumitemwt = sumitemwt
        self.amountget = amountget
        self.intCalculate = intCalculate
    }
    
    static func parseList(_ jsonData:Data!) -> [RedeemDto] {
        
        
        do {
            let list = try JSONDecoder().decode([RedeemDto].self, from: jsonData)
            return list
        } catch  {
            return []
        }
    }
}
