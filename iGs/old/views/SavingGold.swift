//
//  SavingGoldViewController.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 25/10/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import UIKit

/// หน้าออมทอง
class SavingGold: VCBase {

    var rootView = SavingGoldView()
    
    override func setupView() {
        super.setupView()
        setTitleText(text: "ทำรายการออมทอง")
        addRootView(v: rootView)
    }
    
}
