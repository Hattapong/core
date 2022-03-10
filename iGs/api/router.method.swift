//
//  router.verb.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 20/10/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import Foundation
import  Alamofire


extension Router {
    
    var method: Alamofire.HTTPMethod {
        
        switch self {
            
            case .login,
                 .addGoldSaving,
                 .changePassword,
                 .register,
                 .addInterest:
                return .post
                
            default : return .get
            
        }
    }
}

