//
//  sbGoldSavingHisVC.swift
//  GoldSavingSTD-ios
//
//  Created by  Quark301 on 24/10/2562 BE.
//  Copyright © 2562  Quark301. All rights reserved.
//

import UIKit
import Alamofire

class sbGoldSavingHisVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var table: UITableView!
    
    
    
    var gsHisList:[GoldSavingDto] = []
    var gsWaitApproveList:[PendingSavingDto] = []
    var useGsList:[SpendingDto] = []
    var wdHisList:[WithdrawingDto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(cgColor: #colorLiteral(red: 0.003426580923, green: 0.09713288397, blue: 0.5780642033, alpha: 1))], for: .normal)
            segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(cgColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))], for: .selected)
            segment.selectedSegmentTintColor = UIColor(cgColor: #colorLiteral(red: 0.003426580923, green: 0.09713288397, blue: 0.5780642033, alpha: 1))
            segment.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        table.dataSource = self
        table.delegate = self

        initList()
    }
    
    func initList(){
        
        getGSHisList()
        getUseGSList()
        getWDGSList()
        getWaitApproveList()
    }
    
    func getGSHisList() {
        let router = Router.goldsavings
        AF.request(router).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                do {
                    //here dataResponse received from a network request
                    let decoder = JSONDecoder()
                    let list = try decoder.decode([GoldSavingDto].self, from:
                        response.data!) //Decode JSON Response Data
                    
                    self.gsHisList = list
                    
                    
                } catch _ {
                    self.gsHisList = []
                }
            case .failure( _):
                self.gsHisList = []
            }
            
            self.table.reloadData()
        }
    }
    
    func getWaitApproveList() {
        let router = Router.pendingSavings
        AF.request(router).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                do {
                    //here dataResponse received from a network request
                    let decoder = JSONDecoder()
                    let list = try decoder.decode([PendingSavingDto].self, from:
                        response.data!) //Decode JSON Response Data
                    
                    self.gsWaitApproveList = list
                    
                    
                } catch _ {
                    self.gsWaitApproveList = []
                }
            case .failure( _):
                self.gsWaitApproveList = []
            }
            
            self.table.reloadData()
        }
    }
    
    func getUseGSList() {
        let router = Router.spendingSavings
        AF.request(router).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                do {
                    //here dataResponse received from a network request
                    let decoder = JSONDecoder()
                    let list = try decoder.decode([SpendingDto].self, from:
                        response.data!) //Decode JSON Response Data
                    
                    self.useGsList = list
                    
                    
                } catch _ {
                    self.useGsList = []
                }
            case .failure( _):
                self.useGsList = []
            }
            
            self.table.reloadData()
        }
    }

    func getWDGSList() {
        let router = Router.withdraws
        AF.request(router).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                do {
                    //here dataResponse received from a network request
                    let decoder = JSONDecoder()
                    let list = try decoder.decode([WithdrawingDto].self, from:
                        response.data!) //Decode JSON Response Data
                    
                    self.wdHisList = list
                    
                    
                } catch _ {
                    self.wdHisList = []
                }
            case .failure( _):
                self.wdHisList = []
            }
            
            self.table.reloadData()
        }
    }
    
    @IBAction func segment_OnChanged(_ sender: UISegmentedControl) {
        table.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segment.selectedSegmentIndex == 0 {
            return gsHisList.count
        } else if segment.selectedSegmentIndex == 1 {
            return wdHisList.count
        } else if segment.selectedSegmentIndex == 2 {
            return useGsList.count
        } else if segment.selectedSegmentIndex == 3 {
            return gsWaitApproveList.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segment.selectedSegmentIndex == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GSHisCell") as! GSHisTVC
            let row = gsHisList[indexPath.row]
            
            cell.billNum.text = row.billnum
            cell.billDate.text = row.billdate.asShortDateFormat()
            cell.savingAmt.text = row.savingAmt.toString()
            cell.approvedStatus.text = row.approved
            
            return cell
        } else if segment.selectedSegmentIndex == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "wdCell") as! WDHisTVC
            let row = wdHisList[indexPath.row]
            
            cell.billNum.text = row.billnum
            cell.billDate.text = row.billdate.asShortDateFormat()
            cell.widrawAmt.text = row.withdrawAmt.toString()
            
            return cell
        } else if segment.selectedSegmentIndex == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "UseSavCell") as! UseGSHisTVC
            let row = useGsList[indexPath.row]
            
            cell.refNum.text = row.refnum
            cell.sellDate.text = row.sellDate.asShortDateFormat()
            cell.amt.text = row.amt.toString()
            
            return cell
        } else if segment.selectedSegmentIndex == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "wait") as! WaitApproveCell
            let row = gsWaitApproveList[indexPath.row]
            
            cell.id.text = "ref:\(row.id.toString())"
            cell.payDate.text = row.paydate?.asDateFormat2() ?? ""
            cell.savingAmt.text = (row.savingAmt ?? 0).toString() + "฿"
            var approveText: String = ""
            if row.approved == nil {
                approveText = "รออนุมัติ"
            } else if row.approved == false {
                approveText = "ไม่อนุมัติ"
            }
            cell.status.text = approveText
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if segment.selectedSegmentIndex == 0 {
            return CGFloat(integerLiteral: 85)
        } else if segment.selectedSegmentIndex == 1 {
            return CGFloat(integerLiteral: 43)
        } else if segment.selectedSegmentIndex == 2 {
            return CGFloat(integerLiteral: 43)
        } else if segment.selectedSegmentIndex == 3 {
            return CGFloat(integerLiteral: 59)
        } else {
            return 0
        }
    }
}
