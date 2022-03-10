//
//  vBranchSelecter.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 1/7/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import UIKit
import Alamofire

class BranchSelecter : NSObject {
    let rowHeight: CGFloat = 40.0
    var tableHeight: CGFloat {
        return rowHeight * CGFloat(BranchSelecter.branchs?.count ?? 0) + 40
    }
    
    let backdrop = UIView()
    let content: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        return v
    }()
    let table: UITableView = {
        let v = UITableView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var selectCallback : ((BranchBank) -> Void)? = nil
    
    static var branchs: [BranchBank]? = nil
    
    func show(){
        
        if let window  = keyWindow {
            let wf = window.frame
            backdrop.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4592519264)
            backdrop.frame = wf
            window.addSubview(backdrop)
            window.addSubview(content)
            
            backdrop.alpha = 0
            self.content.frame  = CGRect(x: 0, y: wf.height, width: wf.width, height: 200)
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.backdrop.alpha = 1
                self.content.frame  = CGRect(x: 0, y: wf.height - self.tableHeight, width: wf.width, height: self.tableHeight)
            }) { _ in }
            
            backdrop.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismiss)))
            
        }
    }
    
    
    
    @objc func dismiss(){
        guard let window = keyWindow else { return }
        let wf = window.frame
        
//        backdrop.alpha = 1
//        self.content.frame  = CGRect(x: 0, y: wf.height - 200, width: wf.width, height: 200)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.backdrop.alpha = 0
            self.content.frame  = CGRect(x: 0, y: wf.height, width: wf.width, height: 200)
        }) { _ in
            
        }
    }
    
    override init() {
        super.init()
        
        if BranchSelecter.branchs == nil {
            fetchBranch()
        }
        
        content.addSubview(table)
        content.addConstrainsWithFormat(format: "|[v0]|", views: table)
        content.addConstrainsWithFormat(format: "V:|[v0]|", views: table)
        
        table.register(BranchBankCell.self, forCellReuseIdentifier: "cell")
        table.dataSource = self
        table.delegate = self
        table.rowHeight = rowHeight
    }
    
    func fetchBranch(){
        let router = Router.branchsBank(branchname: nil)
        AF.request(router).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                do {
                    //here dataResponse received from a network request
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode([BranchBank].self, from:
                        response.data!) //Decode JSON Response Data
                    
                    BranchSelecter.branchs = decodedData
                    self.table.reloadData()
                } catch let parsingError {
                    print("Error", parsingError)
                }            case .failure(let error):
                    print(error)
            }
        }
    }
}

extension BranchSelecter: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let branchs = BranchSelecter.branchs {
            return branchs.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BranchBankCell
        
        if let branchs = BranchSelecter.branchs {
            cell.label.text = branchs[indexPath.row].branchname ?? "error branch's name"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let callback = selectCallback, let b = BranchSelecter.branchs {
            callback(b[indexPath.row])
        }
        dismiss()
    }
}
