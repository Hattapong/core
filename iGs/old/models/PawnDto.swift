//
//  PawnDto.swift
//  GoldSavingSTD-ios
//
//  Created by  Quark301 on 19/2/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

//   let pawnDto = try? newJSONDecoder().decode(PawnDto.self, from: jsonData)

import Foundation

// MARK: - PawnDto
class PawnDto: Codable {
//    init(pawnid: String? = nil, amountget: Double? = nil, months: Int? = nil, indate: String? = nil, sumdescription: String? = nil, sumitemwt: Double? = nil, branchname: String? = nil) {
//        self.pawnid = pawnid
//        self.amountget = amountget
//        self.months = months
//        self.indate = indate
//        self.sumdescription = sumdescription
//        self.sumitemwt = sumitemwt
//        self.branchname = branchname
//    }
    
    var pawnid: String?
    var amountget: Double?
    var months: Int?
    var indate, sumdescription: String?
    var sumitemwt: Double?
    var branchname: String?
    var duedate : String?

    
    static func parseList(_ jsonData:Data!) -> [PawnDto] {
        let pawnDto = try! JSONDecoder().decode([PawnDto].self, from: jsonData)
        return pawnDto
    }
    
    static func parse(_ jsonData:Data!) -> PawnDto {
        let pawnDto = try! JSONDecoder().decode(PawnDto.self, from: jsonData)
        return pawnDto
    }
}

