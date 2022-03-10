//
//  InterestPawn.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 25/10/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import UIKit
import Alamofire

class InterestPawn : VCBase {
    
    let CELLID = "cell"
    
    var items: [PawnDto] = [] {
        didSet {
            //print(items)
            self.table.reloadData()
            //self.refreshControl.endRefreshing()
        }
    }
    
    override func setupView() {
        super.setupView()
        setTitleText(text: "ชำระค่าดอกเบี้ย")
        addTable()
        
        fetchData()
    }
    
    func addTable(){
        addRootView(v: table)
    }
    
    func fetchData() {
        let router = Router.pawnToInterests
        AF.request(router).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                do {
                    //print(String(data: response.data!, encoding: String.Encoding.utf8))
                    self.items = PawnDto.parseList(response.data)
                    
                }
            case .failure( let err):
                self.items = []
                print(err)
            }
        }
        
    }
    
    
    
    // MARK: - view
    
    lazy var table: UITableView = {
        let v = UITableView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.separatorStyle = .none
        
        //let nib = UINib.init(nibName: "InterestPawnCell", bundle: nil)
        
        v.register(InterestPawnCell.self, forCellReuseIdentifier: CELLID)
        v.dataSource = self
        v.delegate = self
        v.addSubview(refresher)
        v.allowsSelection = false
        refresher.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return v
    }()
    
    
    var refresher = UIRefreshControl()
    @objc func refresh(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.fetchData()
        }
        
    }
}

extension InterestPawn : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELLID, for: indexPath) as! InterestPawnCell
        
        cell.delegate = self
        cell.data = items[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

extension InterestPawn : InterestPawnCellDelegate {
    func detail(item: PawnDto) {
        let vc = InterestHistoryVC()
        vc.data = item
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func interest(item: PawnDto) {
        let vc = InterestFormVC()
        vc.data = item
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
}


class InterestPawnCell : UITableViewCell {
    
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var billnum: UILabel!
    @IBOutlet weak var beginDate: UILabel!
    @IBOutlet weak var dueDate: UILabel!
    @IBOutlet weak var itemsSummary: UILabel!
    @IBOutlet weak var branchname: UILabel!
    
    var delegate: InterestPawnCellDelegate? = nil
    
    var data: PawnDto? = nil {
        didSet {
            guard let data = data else { return }
            
            billnum.text = data.pawnid
            beginDate.text = data.indate?.asShortDateFormat()
            dueDate.text = data.duedate?.asShortDateFormat()
            itemsSummary.text = data.sumdescription
            branchname.text = data.branchname
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
    
    @IBAction func showDetail(_ sender: Any) {
        if let d = delegate, let data = data {
            d.detail(item: data)
        }
    }
    
    @IBAction func doInterest(_ sender: Any) {
        if let d = delegate, let data = data {
            d.interest(item:data)
        }
    }
    
    func commonInit(){
        let nib = String(describing: InterestPawnCell.self)
        Bundle(for: InterestPawnCell.self).loadNibNamed(nib, owner: self, options: nil)
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


protocol InterestPawnCellDelegate {
    
    func detail(item: PawnDto)
    func interest(item: PawnDto)
    
}
