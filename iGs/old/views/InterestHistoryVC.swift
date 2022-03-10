//
//  InterestHistoryVC.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 27/10/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import UIKit
import Alamofire
import PopupDialog

class InterestHistoryVC: VCBase {
    
    let CELLID = "cell"
    
    var data: PawnDto? = nil {
        didSet {
            guard let data = data else { return }
            
            setTitleText(text: data.pawnid!)
        }
    }
    
    var intPaids: [InterestDto]? = nil {
        didSet { handleIntPaidsSet(list: intPaids) }
    }
    
    override func setupView() {
        super.setupView()
        
        setupTable()
        
        fetchData()
    }
    
    func setupTable(){
        addRootView(v: table)
        
    }
    
    func fetchData() {
        let router = Router.intPaids
        AF.request(router).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                do {
                    
                    let list = try! JSONDecoder().decode([InterestDto].self, from: response.data!)
                    
                    //print(String(data: response.data!, encoding: String.Encoding.utf8)!)
                    
                    self.intPaids = list.filter({ (i) -> Bool in
                        i.refnum == self.data?.pawnid
                            && i.branchname == self.data?.branchname
                    })
                }
            case .failure( let err):
                self.intPaids = []
                print(err)
            }
            
            
        }
        
    }
    
    func handleIntPaidsSet(list: [InterestDto]?) {
        table.reloadData()
        guard let list = list else { return }
        
        if list.count == 0 { alertNotfound() }
    }
    
    func alertNotfound(){
       
        let title = "ไม่พบรายการ"
        let msg = "รายการนี้ไม่พบประวัติการต่อดอก"
        let popup = PopupDialog(title: title, message: msg, tapGestureDismissal: false, panGestureDismissal: false)
        
        
        let btn = DefaultButton(title: "ตกลง") {
            self.dismiss(animated: true, completion: nil)
        }
        btn.titleFont = UIFont(name: "Trirong-ExtraLight", size: 18)!
        btn.titleColor = #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)
        
        popup.addButtons([btn])
        
        self.present(popup, animated: true, completion: {
            
        })
        
        let vc = popup.viewController as! PopupDialogDefaultViewController
        vc.titleFont = UIFont(name: "Trirong", size: 18)!
        vc.messageFont = UIFont(name: "Trirong-Light", size: 18)!
        
    }
    
    // MARK: - view
    lazy var table: UITableView = {
        let v = UITableView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.separatorStyle = .none
        v.register(IntPaidCell.self, forCellReuseIdentifier: CELLID)
        v.dataSource = self
        v.delegate = self
        //v.addSubview(refresher)
        v.allowsSelection = false
        //refresher.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return v
    }()
}

extension InterestHistoryVC  : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return intPaids?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELLID, for: indexPath) as! IntPaidCell
        
        cell.data = intPaids![indexPath.row]
        return cell
    }
    
    
}

class IntPaidCell: UITableViewCell {
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var billnum: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var intAmount: UILabel!
    
    
    var delegate: InterestPawnCellDelegate? = nil
    
    var data: InterestDto? = nil {
        didSet {
            guard let data = data else { return }
            
            billnum.text = data.refnum
            date.text = data.trandate?.asShortDateFormat()
            intAmount.text = data.amountreceive?.toString()
           
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    
    func commonInit(){
        let _class = type(of: self)
        let nib = String(describing: _class)
        Bundle(for: _class).loadNibNamed(nib, owner: self, options: nil)
        contentView.addSubview(rootView)
        rootView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rootView.topAnchor.constraint(equalTo: contentView.topAnchor),
            rootView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            rootView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rootView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
