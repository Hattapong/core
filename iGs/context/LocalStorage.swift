//
//  LocalStorage.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 9/7/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import Foundation




enum LocalStorage {
    
    case shopURL
    case shopRef
    
    
    fileprivate var key: String {
        switch self {
        case .shopURL:
            return "shopURL"
        case .shopRef:
            return "shopRef"
        }
    }
    
    
    func setValue(value: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: self.key)
    }

    func getValue() -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: self.key)
    }

    func clearValue(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: self.key)
    }

}
