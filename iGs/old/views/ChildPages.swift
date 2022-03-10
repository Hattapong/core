//
//  CellPageTemplate.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 21/10/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import UIKit


enum ChildPages {
    
    case main
    case histoty
    case transaction
    case contact
    
    
    
    func label() -> String {
        switch self {
            case .main: return "หน้าหลัก"
            case .histoty: return "ประวัติ"
            case .transaction: return "ทำรายการ"
            case .contact: return "ติดต่อเรา"
        }
    }
    
    
    func icon() -> UIImage {
        switch self {
            case .main: return #imageLiteral(resourceName: "home")
            case .histoty: return #imageLiteral(resourceName: "history")
            case .transaction: return #imageLiteral(resourceName: "transaction")
            case .contact: return #imageLiteral(resourceName: "contact")
        }
    }
    
    
    func creatView() -> UIView {
        
        let v = UIView()
        let i = UIImageView(image: icon())
        
        v.addSubview(i)
        i._h(32)._w(32).useAL()
        i.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        i.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
        

        
        return v
    }
    

    func creatLabel() -> UILabel {
        let label = UILabel()
        label.useAL()
        label.text = self.label()
        return label
    }
    
    func getPageView() -> UIView {
       
        
        switch self {
        
        case .main:
            return HomeView()
        
        case .histoty:
            let subMenuView = MenuTableView()
            subMenuView.items = MenusRepo.HistoryMenus
            return subMenuView
            
        case .transaction:
            let subMenuView = MenuTableView()
            subMenuView.items = MenusRepo.TransactionMenus
            return subMenuView
        
        case .contact:
            return ContactView()
        }
        
        
        
    }
}
