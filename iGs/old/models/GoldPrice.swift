//
//  GoldPrice.swift
//  GoldSavingSTD-ios
//
//  Created by  Quark301 on 24/10/2562 BE.
//  Copyright © 2562  Quark301. All rights reserved.
//

import Foundation

struct GoldPrice: Codable {
    var Sale:Double
    var Buy:Double
    var full:Pricefull
}

struct Pricefull: Codable {
    var time:String
    var goldbar: PriceGoldbar
    var gold: PriceGold
}

struct PriceGoldbar: Codable {
    var sale: Double
    var buy: Double
}

struct PriceGold: Codable {
    var sale: Double
    var buy: Double
}
