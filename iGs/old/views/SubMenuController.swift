//
//  MenuTransaction.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 21/10/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import UIKit

class SubMenuController: UIViewController {
    
    var items:[SubMenuItemContent] = []
    
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var headTitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        
        print("load")
    }
  
}

extension SubMenuController : MenuTableViewCellDelegate {
    func select(tag: MenuTags) {
        
    }
    
}


extension SubMenuController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MenuTableViewCell
        
        cell.delegate = self
        cell.content = items[indexPath.row]
    print("vxc")
        return cell
    }
    
    
}

class SubMenuItemContent {
    
    let image:UIImage
    let name:String
    let title:String
    let tag:MenuTags
    
    init(_ image:UIImage,
         _ name:String,
         _ title:String,
         _ tag:MenuTags) {
        self.image = image
        self.name = name
        self.title = title
        self.tag = tag
    }
    
}
