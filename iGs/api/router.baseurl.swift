//
//  router.baseurl.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 20/10/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import Foundation
import Alamofire


extension Router {

    var baseUrl: String {
        switch self {
            
            case .goldprice: return "http://150.95.30.84:5555"
                
            case .findShop: return "http://150.95.88.158:9000"
                
            default: return apiUrlBase
            
            
        }
    }
}
