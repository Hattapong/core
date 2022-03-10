//
//  ContractidCell.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 2/7/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import UIKit

class ContractidCell: UITableViewCell {
    
        var label: UILabel = {
            let v = UILabel()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            v.font = UIFont(name: "Trirong", size: 18)
            return v
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            contentView.addSubview(label)
            
            contentView.addConstrainsWithFormat(format: "|-[v0]", views: label)
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
