//
//  Context.swift
//  iGS_SRV
//
//  Created by Hattapong on 7/9/2564 BE.
//

import UIKit

var userContext:UserProfile? = nil
var appContext:AppData? = nil
var logoContext:UIImage? = nil

//
//func getContext<T>(of:T) -> T? where T:Any {
//     
//    if of is UserProfile {
//        return (userContext as! T)
//    }
//    
//    
//    return nil
//}


let keyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first
