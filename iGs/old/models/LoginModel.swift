//
//  LoginModel.swift
//  GoldSavingSTD-ios
//
//  Created by  Quark301 on 18/10/2562 BE.
//  Copyright © 2562  Quark301. All rights reserved.
//

import Foundation

struct LoginModel: Codable {
    var username:String?
    var password:String?
    
    init(username:String, password:String) {
        self.username = username
        self.password = password
    }
}
