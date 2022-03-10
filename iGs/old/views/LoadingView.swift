//
//  LoadingView.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 26/10/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import UIKit


class LoadingView: NSObject {
    
    let tag = 1232423
    
    let indecator: UIView = {
        let v = UIView()
        v.backgroundColor = .green
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let container:UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    override init() {
        super.init()
        
        container.addSubview(indecator)
        
        NSLayoutConstraint.activate([
            indecator.widthAnchor.constraint(equalToConstant: 200),
            indecator.heightAnchor.constraint(equalToConstant: 200),
            indecator.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            indecator.centerXAnchor.constraint(equalTo: container.centerXAnchor),
         
        ])
    }
    
    func show(){
        
        
        if let window = keyWindow {
            
//            container.alpha = 0.2
            container.frame = window.frame
            
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: .greatestFiniteMagnitude, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
//                self.container.alpha = 1
//            }, completion: nil)
            
            window.addSubview(container)
        }
    }
    

}
