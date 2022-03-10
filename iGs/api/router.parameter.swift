//
//  route.parameter.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 20/10/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import Foundation
import Alamofire

extension Router {
    
    public var parameters: [String: Any]? {
        switch self {
            
            
            
        case .login(let username, let password):
            return [
                "username": username,
                "password": password
            ]
            
            
            
        case .branchsBank(let branchname) :
            
            if let b = branchname {
                return ["branchname": b]
            }
            else {
                return nil
            }
            
            
            
        case .changePassword(let _old, let _new):
            return [
                "password": _new,
                "oldPassword": _old
            ]
            
            
        case .register(let input):
            return [
                "custname": input.custname ?? "",
                "savingAmt": input.savingAmt ?? 0,
                "bankName": input.bankName ?? "",
                "bankID": input.bankID ?? "",
                "thaiid": input.thaiid ?? "",
                "address": input.address ?? "",
                "amphur": input.amphur ?? "",
                "province": input.province ?? "",
                "zipcode": input.zipcode ?? "",
                "paydate": input.paydate ?? "",
                "phone": input.phone ?? ""
            ]
            
            
        default: return nil
            
            
        }
    }
}
