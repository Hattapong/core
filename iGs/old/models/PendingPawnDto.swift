//
//  File.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 17/3/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//
//   let waitingInterestForListDto = try? newJSONDecoder().decode(WaitingInterestForListDto.self, from: jsonData)

import Foundation

// MARK: - WaitingInterestForListDto
struct PendingPawnDto: Codable {
    var pawnid: String?
    var amountpay: Double?
    var months: Int?
    var paydate: String?
    var checkPayStatus: Bool?
}

