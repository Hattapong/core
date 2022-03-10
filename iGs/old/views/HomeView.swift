//
//  HomeView.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 22/10/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import UIKit
import Alamofire
import ProgressHUD

class HomeView: UICollectionViewCell {
    
    let cellid = "cell"
    
    let refresh = UIRefreshControl()
    
    var news:[NewsObj] = [] {
        didSet {
            
            if news.count > 0 {
                self.advWrapper.isHidden = false
                self.cvAdvs.reloadData()
            } else {
                self.advWrapper.isHidden = true
            }
            
        }
    }
    
    var newsIndex:Int = 0
    
    var cachedNews:[Int:UIImage] = [:]
    
    var fetchCount = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
        
        fetchCount = 2
        ProgressHUD.colorBackground = .black.withAlphaComponent(0.3)
        ProgressHUD.show()
        
        populateBalance{
            self.clearHUDIfFetchDone()
        }
        
        populateGoldPrice{
            self.clearHUDIfFetchDone()
        }
        
        getNews()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        circle.layer.cornerRadius = frame.width / 3 / 2
        cvAdvs.reloadData()
    }
    
    // MARK: -  init view
    func initView(){
        backgroundColor = .white
        
        // MARK: -  add background
        addSubview(ivBackground)
        addConstrainsWithFormat(format: "|-0-[v0]-0-|", views: ivBackground)
        addConstrainsWithFormat(format: "V:|-0-[v0]-0-|", views: ivBackground)
        
        
        addSubview(ivHead)
        ivHead.topAnchor.constraint(equalTo: topAnchor).isActive = true
        ivHead.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        ivHead.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        ivHead.heightAnchor.constraint(equalTo: ivHead.widthAnchor, multiplier: 0.8).isActive = true
        
        addSubview(scrMain)
        NSLayoutConstraint.activate([
            scrMain.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            scrMain.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            scrMain.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            scrMain.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            
        ])
        
        scrMain.addSubview(wrapperView)
        NSLayoutConstraint.activate([
            wrapperView.topAnchor.constraint(equalTo: scrMain.topAnchor),
            wrapperView.widthAnchor.constraint(equalTo: scrMain.widthAnchor),
            wrapperView.centerXAnchor.constraint(equalTo: scrMain.centerXAnchor),
            //wrapperView.heightAnchor.constraint(equalToConstant: 1200),
            wrapperView.bottomAnchor.constraint(equalTo: scrMain.bottomAnchor),
        ])
        
        
        
        
        wrapperView.addSubview(stMain)
        NSLayoutConstraint.activate([
            stMain.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 10),
            stMain.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 10),
            stMain.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -10),
            stMain.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -120),
        ])
        
        
        stMain.addArrangedSubview(ivLogo)
        ivLogo.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        stMain.addArrangedSubview(lblBalanceTitle)
        lblBalanceTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        stMain.addArrangedSubview(circle)
        circle.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3).isActive = true
        circle.heightAnchor.constraint(equalTo: circle.widthAnchor, multiplier: 1).isActive = true
        
        circle.addSubview(lblBalance)
        lblBalance._cenX()._cenY().useAL()
        
        
        let v1 = UIView()
        v1.backgroundColor = .clear
        v1._h(60)._w(200).useAL()
        stMain.addArrangedSubview(v1)
        
        stMain.addArrangedSubview(btnPrice)
        btnPrice._w(150)._h(60).useAL()
        
        stMain.addArrangedSubview(lblDate)
        lblDate._h(40).useAL()
        
        stMain.addArrangedSubview(stPrice)
        stPrice._h(120).useAL()
        stPrice.widthAnchor.constraint(equalTo: stMain.widthAnchor).isActive = true
        
        let bd1 = genBorder()
        let bd2 = genBorder()
        
        stPrice.addArrangedSubview(bd1)
        stPrice.addArrangedSubview(bd2)
        
        let lbl1 = genLabel()
        lbl1.text = "ราคาทองซื้อ"
        let lbl2 = genLabel()
        lbl2.text = "ราคาทองขาย"
        
        let st1 = genVStack()
        bd1.addSubview(st1)
        st1._to_top(10)._to_bot(-20)._to_left(0)._to_right(0).useAL()
        st1.addArrangedSubview(lbl1)
        st1.addArrangedSubview(lblPriceBuy)
        
        let st2 = genVStack()
        bd2.addSubview(st2)
        st2._to_top(10)._to_bot(-20)._to_left(0)._to_right(0).useAL()
        st2.addArrangedSubview(lbl2)
        st2.addArrangedSubview(lblPriceSell)
        
        let v2 = UIView()
        v2.backgroundColor = .clear
        v2._h(30)._w(200).useAL()
        stMain.addArrangedSubview(v2)
        
        
        
        stMain.addArrangedSubview(advWrapper)
        advWrapper.widthAnchor.constraint(equalTo: scrMain.widthAnchor, multiplier: 1).isActive = true
        advWrapper.widthAnchor.constraint(equalTo: advWrapper.heightAnchor, multiplier: 2 / 1).isActive = true
        
        advWrapper.addSubview(cvAdvs)
        advWrapper.addConstrainsWithFormat(format: "H:|-0-[v0]-0-|", views: cvAdvs)
        advWrapper.addConstrainsWithFormat(format: "V:|-0-[v0]-0-|", views: cvAdvs)
        
        
        advWrapper.addSubview(indicator)
        advWrapper.addConstrainsWithFormat(format: "H:|-0-[v0]-0-|", views: indicator)
        advWrapper.addConstrainsWithFormat(format: "V:[v0(40)]", views: indicator)
        indicator.centerYAnchor.constraint(equalTo: advWrapper.centerYAnchor).isActive = true
        
        
        cvAdvs.register(NewsCell.self, forCellWithReuseIdentifier: cellid)
        
        scrMain.refreshControl = refresh
        refresh.addTarget(self, action: #selector(handleRefreshed), for: .valueChanged)
        
        cvAdvs.dataSource = self
        cvAdvs.delegate = self
        
        
        
        indicator.onTapNext = {
            if self.newsIndex < self.news.count - 1 {
                self.scrollToItem(at: self.newsIndex + 1)
            }
        }
        indicator.onTapPrev = {
            if self.newsIndex > 0 {
                self.scrollToItem(at: self.newsIndex - 1)
            }
        }
    }
    
    fileprivate func clearHUDIfFetchDone(){
        if fetchCount > 0 {
            fetchCount -= 1
        }
        
        if fetchCount == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                ProgressHUD.dismiss()
            }
            
        }
    }
    
    
    
    // MARK: -  refresh gold price
    @objc func handleRefreshed(){
        
        fetchCount = 2
        ProgressHUD.colorBackground = .black.withAlphaComponent(0.3)
        ProgressHUD.show()
        
        populateBalance{
            self.clearHUDIfFetchDone()
        }
        
        populateGoldPrice{
            self.clearHUDIfFetchDone()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.refresh.endRefreshing()
        }
        
    }
    
    
    
    // MARK: -  fetch gold price
    private func populateGoldPrice(then: @escaping ()->Void ) {
        
        let router = Router.goldprice
        AF.request(router).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                do {
                    //here dataResponse received from a network request
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(GoldPrice.self, from:
                                                    response.data!) //Decode JSON Response Data
                    
                    self.lblPriceBuy.text = "\((model.full.goldbar.buy).toString())"
                    self.lblPriceSell.text = "\(model.Sale.toString())"
                    self.lblDate.text = "\(model.full.time.asShortDateFormat())"
                    
                    //2019-10-24T09:26:00
                } catch _ {
                    self.handlerGoldPriceError()
                }
            case .failure( _):
                self.handlerGoldPriceError()
            }
            
            then()
            
        }
    }
    
    
    // MARK: -  fetch balance
    private func populateBalance(then: @escaping ()->Void) {
        let router = Router.savingBalance
        AF.request(router).validate().response{ (response) in
            switch response.result {
            case .success:
                do {
                    
                    
                    let val = String(data: response.data!, encoding: String.Encoding.utf8)
                    guard val != nil else {
                        throw ErrorModel.runtimeError("no value.")
                    }
                    let balanceVal = Double(val!)
                    
                    self.lblBalance.text = balanceVal?.toString()
                    
                    
                } catch _ {
                    print("error json parse.")
                    self.handlerBalanceError()
                }
            case .failure( _):
                print("error get response \(String(describing: response.response?.statusCode)).")
                self.handlerBalanceError()
            }
            
            then()
        }
    }
    
    
    
    // MARK: -  fetch news
    private func getNews() {
        
        
        let route = Router.newFeeds
        AF.request(route).validate().response { (response) in
            switch response.result {
            
            case .success(let jsonData):
                
                self.news = NewsObj.parseList(jsonData!)
            case .failure(let err):
                
                print(err.errorDescription as Any)
                self.news = []
            }
            
        }
        
        
    }
    
    private func handlerGoldPriceError() {
        lblPriceBuy.text = "-"
        lblPriceSell.text = "-"
        lblDate.text = "-"
    }
    
    private func handlerBalanceError(){
        self.lblBalance.text = "error"
    }
    
    lazy var ivBackground:UIImageView = {
        let v = UIImageView(image: #imageLiteral(resourceName: "bg_gd_02"))
        v.useAL()
        v.contentMode = .scaleToFill
        
        return v
    }()
    
    
    lazy var ivHead:UIImageView = {
        let v = UIImageView(image: #imageLiteral(resourceName: "bg_home_top"))
        v.useAL()
        v.contentMode = .scaleToFill
        
        
        return v
    }()
    
    lazy var scrMain:UIScrollView = {
        let v = UIScrollView()
        v.useAL()
        v.showsVerticalScrollIndicator = false
        return v
    }()
    
    lazy var wrapperView:UIView = {
        let v = UIView()
        v.useAL()
        v.backgroundColor = .clear
        return v
    }()
    
    lazy var stMain:UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.useAL()
        v.alignment = .center
        return v
    }()
    
    lazy var ivLogo:UIImageView = {
        let v = UIImageView(image: getLogoImage())
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFit
        return v
    }()
    
    lazy var lblBalanceTitle:UILabel = {
        let v = UILabel()
        v.useAL()
        v.text = "ยอดคงเหลือ"
        v.adjustsFontSizeToFitWidth = true
        v.textAlignment = .center
        v.font = fNormalWith(size: 38)
        v.textColor = #colorLiteral(red: 0.5882352941, green: 0.168627451, blue: 0.1333333333, alpha: 1)
        return v
    }()
    
    lazy var circle:UIView = {
        let v = UIView()
        v.useAL()
        v.layer.borderWidth = 5
        v.layer.borderColor = #colorLiteral(red: 0.5882352941, green: 0.168627451, blue: 0.1333333333, alpha: 1)
        return v
    }()
    
    lazy var lblBalance:UILabel = {
        let v = UILabel()
        v.font = fH3
        v.textColor = #colorLiteral(red: 0.5882352941, green: 0.168627451, blue: 0.1333333333, alpha: 1)
        return v
    }()
    
    
    lazy var btnPrice:UIButton = {
        let v = UIButton()
        v.setTitle("ราคาทอง", for: .normal)
        v.titleLabel?.font = fH3
        v.setTitleColor(#colorLiteral(red: 0.5882352941, green: 0.168627451, blue: 0.1333333333, alpha: 1), for: .normal)
        v.backgroundColor = #colorLiteral(red: 0.8156862745, green: 0.6705882353, blue: 0.368627451, alpha: 1)
        v.layer.cornerRadius = 10
        return v
    }()
    
    lazy var lblDate:UILabel = {
        let v = UILabel()
        v.useAL()
        v.text = "loading..."
        v.font = fH3
        v.textColor = #colorLiteral(red: 0.5882352941, green: 0.168627451, blue: 0.1333333333, alpha: 1)
        return v
    }()
    
    func genBorder()-> UIView {
        let v = UIView()
        v.useAL()
        v.layer.borderWidth = 2
        v.layer.borderColor = #colorLiteral(red: 0.5882352941, green: 0.168627451, blue: 0.1333333333, alpha: 1)
        v.layer.cornerRadius = 10
        return v
    }
    
    func genVStack() -> UIStackView {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = 10
        return v
    }
    
    func genLabel()-> UILabel {
        let v = UILabel()
        v.useAL()
        v.adjustsFontSizeToFitWidth = true
        v.textAlignment = .center
        v.font = fNormalWith(size: 32)
        v.textColor = #colorLiteral(red: 0.5882352941, green: 0.168627451, blue: 0.1333333333, alpha: 1)
        return v
    }
    
    
    lazy var stPrice:UIStackView = {
        let v = UIStackView()
        v.useAL()
        v.axis = .horizontal
        v.distribution = .fillEqually
        v.spacing = 10
        v.alignment = .fill
        return v
    }()
    
    lazy var lblPriceBuy:UILabel = {
        let v = UILabel()
        v.useAL()
        v.adjustsFontSizeToFitWidth = true
        v.textAlignment = .center
        v.font = fNormalWith(size: 32)
        v.textColor = #colorLiteral(red: 0.5882352941, green: 0.168627451, blue: 0.1333333333, alpha: 1)
        return v
    }()
    
    lazy var lblPriceSell:UILabel = {
        let v = UILabel()
        v.useAL()
        v.adjustsFontSizeToFitWidth = true
        v.textAlignment = .center
        v.font = fNormalWith(size: 32)
        v.textColor = #colorLiteral(red: 0.5882352941, green: 0.168627451, blue: 0.1333333333, alpha: 1)
        return v
    }()
    
    lazy var advWrapper:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.useAL()
        return view
    }()
    
    
    lazy var cvAdvs:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        v.useAL()
        v.isPagingEnabled = true
        v.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.145044491)
        return v
    }()
    
    
    var indicator: Indicator = {
        let v  = Indicator()
        v.useAL()
        return v
    }()
}


extension HomeView : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return news.count
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        var _index =  Int(floor(x / cvAdvs.frame.width))
        
        if _index < 0 { _index = 0 }
        if _index >= news.count { _index = news.count - 1}
        
        newsIndex = _index
        
    }
    
    func scrollToItem(at index:Int){
        self.cvAdvs.isPagingEnabled = false
        cvAdvs.scrollToItem(at: IndexPath(row: index, section: 0), at: .init(), animated: true)
        self.cvAdvs.isPagingEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewsCell
        let item  = news[indexPath.row]
        
        if let img = cachedNews[indexPath.row] {
            cell.ivNews.image = img
        }
        else {
            if let url = item.imageUrls?[0] {
                
                AF.request("http://" + url).validate().response { (response) in
                    switch response.result {
                    case .success(let data):
                        
                        if let image = UIImage(data: data!) {
                            cell.ivNews.image = image
                            self.cachedNews[indexPath.row] = image
                        }
                        
                    case .failure(let err):
                        print(err.errorDescription as Any)
                        
                    }
                    
                    if cell.ivNews.image == nil {
                        cell.ivNews.image =  #imageLiteral(resourceName: "bg_loading")
                    }
                }
                
            }
            
        }
        
        
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cvAdvs.frame.width , height: cvAdvs.frame.height )
        
    }
    
}


class NewsCell: UICollectionViewCell {
    
    var ivNews:UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = true
        v.contentMode = .scaleAspectFill
        v.backgroundColor = .clear
        v.image = #imageLiteral(resourceName: "bg_loading")
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        contentView.backgroundColor = .clear
        contentView.addSubview(ivNews)
        
        
        contentView.addConstrainsWithFormat(format: "V:|-[v0]-|", views: ivNews)
        contentView.addConstrainsWithFormat(format: "|-0-[v0]-0-|", views: ivNews)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



