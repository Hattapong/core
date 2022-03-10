//
//  InterestListCell.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 27/10/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//


import UIKit
import Alamofire

class InterestListCell: UICollectionViewCell {
    
    let CELLID = "cell"
    var items:[InterestDto] = []
    var sumAmount: Double {
        if items.count == 0 { return 0 }
        
        var sum:Double = 0
        for i in items { sum += i.amountreceive ?? 0 }
        return sum
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        
        fetchData()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView(){
        contentView.backgroundColor = .clear
        
        contentView.addSubview(table)
        contentView.addSubview(summaryView)
        
        
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: contentView.topAnchor),
            table.bottomAnchor.constraint(equalTo: summaryView.topAnchor),
            table.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            summaryView.heightAnchor.constraint(equalToConstant: 40),
            summaryView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            summaryView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            summaryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    @objc func refresh(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.fetchData()
        }
        
    }
   
    func fetchData() {
        let router = Router.intPaids
        
        AF.request(router).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                do {
                    //here dataResponse received from a network request
                    let decoder = JSONDecoder()
                    let list = try decoder.decode([InterestDto].self, from:
                        response.data!) //Decode JSON Response Data
                    
                    self.items = list
                    self.summaryView.sumAmount.text = self.sumAmount.toString()
                    self.summaryView.sumTotal.text = list.count.toString()
                    
                } catch _ {
                    self.items = []
                    
                }
            case .failure( _):
                self.items = []
                
            }
            
            self.table.reloadData()
            self.refresher.endRefreshing()
        }
    }
    
    
    
    
    
    // MARK: - view ~~~~
    
    lazy var table: UITableView = {
        let v = UITableView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.separatorStyle = .none
        v.register(InterestItemCell.self, forCellReuseIdentifier: CELLID)
        v.dataSource = self
        v.delegate = self
        v.addSubview(refresher)
        v.allowsSelection = false
        refresher.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return v
    }()
    
    lazy var summaryView: SummaryView = {
        let v = SummaryView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var refresher = UIRefreshControl()
}

extension InterestListCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELLID, for: indexPath) as! InterestItemCell
        cell.detail.data = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
}


class InterestItemCell : UITableViewCell {
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:   reuseIdentifier)
       
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        contentView.addSubview(container)
        container.addSubview(detail)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
           detail.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
           detail.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8),
           detail.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
           detail.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
        ])
    }
    
    // MARK: - view
    
    var container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        v.layer.cornerRadius = 10
        v.layer.borderWidth = 2
        v.layer.borderColor = kColorPrimary.cgColor
        return v
    }()
    
    var detail: InterestCellDetail = {
        let v = InterestCellDetail()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
}

