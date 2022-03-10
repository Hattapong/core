//
//  AlamoFireRounter.swift
//  GoldSavingSTD-ios
//
//  Created by  Quark301 on 22/10/2562 BE.
//  Copyright © 2562  Quark301. All rights reserved.
//

import Alamofire


enum Router: URLRequestConvertible {
    
   
    // MARK: - guest
    
    case login(username: String, password: String)
    case appLogo
    case appData
    case goldprice
    case register(input:InputRegister)
    case newFeeds
    case branchsBank(branchname: String?)
    
    // MARK: - login user
    
    case userProfile
    case savingBalance
    case userContracts
    
    case goldsavings
    case spendingSavings
    case pendingSavings
    case withdraws
    
    case intPaids
    case pawns
    case pawnToInterests
    case pawnHasRedeem
    case pawnPendingInterests
    case pawnDetail(pawnid: String)

    case addGoldSaving
    case changePassword(_old:String, _new:String)
    
    case getPawnForShow(pawnId: String)
    case addInterest
    
    case findShop(keyword:String)
    
    
    fileprivate func addHeaders(_ mutableURLRequest: inout URLRequest) {
        
        if let token = Auth.sharedInstance().token {
            mutableURLRequest.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        }
        
        
        switch self {
            
            case .goldprice: mutableURLRequest
                                .addValue("quark301", forHTTPHeaderField: "api-key-std")
                
            case .addGoldSaving,.register,.addInterest: mutableURLRequest
                                .addValue("multipart/form-data", forHTTPHeaderField: "Content-type")
                
            case .findShop: mutableURLRequest
                                .addValue("what the quark", forHTTPHeaderField: "access_key")
            
            
            default: break
        }
    }
    
    public func asURLRequest() throws -> URLRequest {

        
        let url = URL(string: self.baseUrl + path)!
        
        var mutableURLRequest = URLRequest(url: url)
        
        mutableURLRequest.httpMethod = method.rawValue
        
        addHeaders(&mutableURLRequest)
        
        
        
        switch self {
            case .register, .branchsBank:
                return try Alamofire.URLEncoding.queryString.encode(mutableURLRequest,with: parameters)
            default:
                return try Alamofire.JSONEncoding.default.encode(mutableURLRequest, with: parameters)
        }
    }
    
    
    
    
    
}
