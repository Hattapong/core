//
//  Auth.swift
//  GoldSavingSTD-ios
//
//  Created by  Quark301 on 9/10/2562 BE.
//  Copyright © 2562  Quark301. All rights reserved.
//
import UIKit

class Auth {
    
    private static var instance:Auth? = nil
    
    var token:String? = nil
    var user:User? = nil
    
    init() {
        
    }
    
    public static func sharedInstance()->Auth {
        if(instance == nil) {
            instance = Auth()
        }
        return instance!
    }
    
    public static func logout() {
        instance = nil
        if let window = keyWindow, let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as? LoginViewController {
            vc.preventAutoLogin = true
            window.rootViewController = vc
        }
    }
}


