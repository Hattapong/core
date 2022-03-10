//
//  PawnDetailForRow.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 8/6/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import Foundation


class PawnDetailForRow: Codable {
    var pawnid: String?
    var amountpay: Double?
    var paydate: String?
    var paytime: String?

    
    static func parseList(_ jsonData:Data!) -> [PawnDetailForRow] {
        let pawnDetails = try! JSONDecoder().decode([PawnDetailForRow].self, from: jsonData)
        return pawnDetails
    }
}
