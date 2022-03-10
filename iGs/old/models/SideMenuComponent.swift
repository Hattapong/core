//
//  eMenu.swift
//  GoldSavingSTD-ios
//
//  Created by  Quark301 on 24/10/2562 BE.
//  Copyright © 2562  Quark301. All rights reserved.
//

import UIKit

enum SideMenuComponent : Int,CaseIterable {
    case goldSaving = 0
    case savingHistory = 1
    case interest = 2
    case pawnHistory = 3
    case contect = 4
    case changePass = 5
    case logout = 6
    
    
    var mainStb : UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    var goldSavingStb : UIStoryboard {
        return UIStoryboard(name: "Goldsaving", bundle: nil)
    }
    var pawnStb : UIStoryboard {
        return UIStoryboard(name: "Pawn", bundle: nil)
    }
    var menuStb : UIStoryboard {
        return UIStoryboard(name: "Menu", bundle: nil)
    }
    
    func getVc(storyBoard:UIStoryboard?) -> UIViewController? {
    
        switch self {
        case .goldSaving:
            return goldSavingStb.instantiateViewController(withIdentifier: "goldsaving")
        case .savingHistory:
            return goldSavingStb.instantiateViewController(withIdentifier: "history_gold_saving")
        case .interest:
            return pawnStb.instantiateViewController(withIdentifier: "interest_list")
        case .pawnHistory:
            return pawnStb.instantiateViewController(withIdentifier: "pawnAll")
        case .logout:
            return mainStb.instantiateViewController(withIdentifier: "login")
        case .contect:
            return menuStb.instantiateViewController(withIdentifier: "contact")
        case .changePass:
            return mainStb.instantiateViewController(withIdentifier: "change_pwd")
        
        }
    }
    
    public var text:String {
        switch self {
        case .goldSaving:
            return "ออมทอง"
        case .savingHistory:
            return "ประวัติออมทอง"
        case .interest:
            return "ต่อดอก"
        case .pawnHistory:
            return "ประวัติขายฝาก"
        case .contect:
            return "ติดต่อเรา"
        case .changePass:
            return "เปลี่ยนรหัสผ่าน"
        case .logout:
            return "ออกจากระบบ"
        
        }
    }
}
