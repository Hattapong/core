//
//  NotApprove.swift
//  GoldSavingSTD-ios
//
//  Created by  Quark301 on 21/11/2562 BE.
//  Copyright © 2562  Quark301. All rights reserved.
//
import Foundation
public struct PendingSavingDto: Decodable {

        public var approved : Bool?
        public var bankID : String!
        public var bankName : String!
        public var billdate : String!
        public var billtime : String!
        public var branchname : String!
        public var custid : String!
        public var custname : String!
        public var id : Int!
        public var orderSrc : String!
        public var paydate : String!
        public var paymenttype : String!
        public var remarkMT : String!
        public var savingAmt : Double!
        
}
