//
//  InterestDto.swift
//  GoldSavingSTD-ios
//
//  Created by  Quark301 on 19/2/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

//   let interestDto = try? newJSONDecoder().decode(InterestDto.self, from: jsonData)

import Foundation

// MARK: - InterestDto
class InterestDto: Codable {
    var trandate, refnum, branchname: String?
    var amountreceive, amountget: Double?

//    init(trandate: String?, refnum: String?, amountreceive: Double?, amountget: Double?) {
//        self.trandate = trandate
//        self.refnum = refnum
//        self.amountreceive = amountreceive
//        self.amountget = amountget
//    }
}
