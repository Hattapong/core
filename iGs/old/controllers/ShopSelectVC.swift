//
//  ShopSelectVC.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 8/7/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import UIKit

class ShopSelectVC: UIViewController {
    
    
    let container:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = #colorLiteral(red: 0.7575740218, green: 0.7919268012, blue: 0.954926908, alpha: 1)
        v.layer.cornerRadius = 20
        return v
    }()
    
    let label0:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont(name: "Prompt", size: 32)
        v.text = "เข้าใช้งานผ่าน"
        v.textColor = #colorLiteral(red: 0.01430170983, green: 0.002377036493, blue: 0.320219636, alpha: 1)
        return v
    }()
    
    let label1:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont(name: "Prompt", size: 32)
        v.text = "Quark Agent"
        v.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return v
    }()
    
    let label1container:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = #colorLiteral(red: 0.6242867112, green: 0.6270265579, blue: 0.8790729046, alpha: 1)
        v.layer.cornerRadius = 10
        return v
    }()
    
    let label2:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont(name: "Prompt", size: 28)
        v.text = "ออมทองกับร้านทองทั่วประเทศ"
        v.textAlignment = .center
        v.adjustsFontSizeToFitWidth = true
        v.textColor = #colorLiteral(red: 0.01430170983, green: 0.002377036493, blue: 0.320219636, alpha: 1)
        return v
    }()
    
    let searchContainer:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.clear
        v.layer.cornerRadius = 20
        v.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        v.layer.shadowOffset = .zero
        v.layer.shadowRadius = 5
        v.clipsToBounds = true
        return v
    }()
    
    let label3:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont(name: "Prompt", size: 24)
        v.text = "ใส่รหัสเปิดใช้งานครั้งแรก"
        v.textAlignment = .center
        v.adjustsFontSizeToFitWidth = true
        v.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return v
    }()
    
    let inputContainer:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.clear
        v.layer.cornerRadius = 15
        v.layer.borderColor = #colorLiteral(red: 0.4409931898, green: 0.4618636966, blue: 0.8588064909, alpha: 1)
        v.layer.borderWidth = 2
        return v
    }()
    
    let inputStack:UIStackView = {
        let v = UIStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .horizontal
        v.distribution = .fill
        return v
    }()
    
    let txtSearch:UITextField = {
        let v = UITextField()
        v.backgroundColor = #colorLiteral(red: 0.9022768736, green: 0.9293650985, blue: 0.9905455709, alpha: 1)
        v.layer.cornerRadius = 8
        v.textAlignment = .center
        return v
    }()
    
    let btSearch:UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setImage(UIImage(imageLiteralResourceName: "icon_search"), for: .normal)
        v.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return v
    }()
    
    let resultContainer:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        v.layer.cornerRadius = 10
        return v
    }()
    
    let labelShopname:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont(name: "Prompt", size: 24)
        v.text = "ร้านของคุณ"
        v.textAlignment = .center
        v.adjustsFontSizeToFitWidth = true
        v.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return v
    }()
    
    let btOk:UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setTitle("ตกลง", for: .normal)
        v.layer.cornerRadius = 10
        v.titleLabel?.font = UIFont(name: "Prompt", size: 20)
        v.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        v.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .highlighted)
        v.titleEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        v.backgroundColor = #colorLiteral(red: 0.2960331738, green: 0.3206661344, blue: 0.6847749352, alpha: 1)
        return v
    }()
    
    let labelFinding:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont(name: "Prompt", size: 16)
        v.text = "กำลังตรวจสอบข้อมูล"
        v.textAlignment = .center
        v.alpha = 0
        v.adjustsFontSizeToFitWidth = true
        v.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return v
    }()
    
    var resultTop: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        hideKeyboardWhenTappedAround()
        setupViews()
        resultTop?.constant = 300
        btSearch.addTarget(self, action: #selector(find), for: .touchUpInside)
        
        btOk.addTarget(self, action: #selector(handleSelectShop), for: .touchUpInside)
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        if let _ = getShopUrl() {
//            self.openMainPage()
//        }
//    }
    
    var shopFound: ShopDto? {
        didSet {
            if let shop = shopFound {
                labelShopname.text = shop.owner
                showResultView()
            }
            else {
                labelShopname.text = ""
            }
        }
    }
    
    @objc func find(){

        hideResultView()
        shopFound = nil
        
        ApiService.shared.findShop(keyword: txtSearch.text!, success: { (shop) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.shopFound = shop
            }
            
        }, error: { (err) in
            self.handleNotFound()
        }, completed: nil)
        
    }
    
    func showResultView(){
        self.resultTop?.constant = 15
        resultContainer.alpha = 0
        self.labelFinding.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.resultContainer.alpha = 1
            self.container.layoutIfNeeded()
        }, completion: nil)
    }
    func hideResultView(){
        self.resultTop?.constant = 300
        resultContainer.alpha = 1
        labelFinding.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.resultContainer.alpha = 0
            self.container.layoutIfNeeded()
        }, completion: nil)
        
        
        UIView.animate(withDuration: 0.5, delay: 0.7, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.labelFinding.alpha = 1
        }, completion: nil)
       
    }
    func handleNotFound(){
        self.labelFinding.alpha = 0
        
        LocalStorage.shopRef.clearValue() 
        
        let alert = UIAlertController(title: "รหัสไม่ถูกต้อง", message: "โปรดตรวจสอบข้อมูลหรือติดต่อร้าน", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ตกลง", style: .default, handler: { (action) in
            alert.dismiss(animated: true) {
                
            }
        }))
        
        present(alert, animated: true, completion: {
            
        })
        
    }
    @objc func handleSelectShop(){
        if let shop = shopFound {
            LocalStorage.shopRef.setValue(value: shop.refCode!)
            LocalStorage.shopURL.setValue(value: shop.url!)
            openMainPage()
        }
    }
    
    func openMainPage(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "startup")
        vc.modalPresentationStyle = .fullScreen
        self.show(vc, sender: nil)
    }
    
    func setupViews(){
        view.backgroundColor = #colorLiteral(red: 0.6242867112, green: 0.6270265579, blue: 0.8790729046, alpha: 1)
        
        view.addSubview(container)
        
        view.addConstrainsWithFormat(format: "H:|-(10)-[v0]-(10)-|", views: container)
        view.addConstrainsWithFormat(format: "V:[v0]-(10)-|", views: container)
        container.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10).isActive = true
      
//
//        container.addSubview(label0)
//        container.addConstrainsWithFormat(format: "V:|-(15)-[v0]", views: label0)
//        label0.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
//
//        container.addSubview(label1container)
//        container.addConstrainsWithFormat(format: "V:[v0]-(10)-[v1]", views: label0, label1container)
//        label1container.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
//
//        label1container.addSubview(label1)
//        label1container.addConstrainsWithFormat(format: "V:|-[v0]-|", views: label1)
//        label1container.addConstrainsWithFormat(format: "|-(15)-[v0]-(15)-|", views: label1)
//
//        container.addSubview(label2)
//        container.addConstrainsWithFormat(format: "V:[v0]-(10)-[v1]", views: label1container, label2)
//        container.addConstrainsWithFormat(format: "|-(20)-[v0]-(20)-|", views: label2)
        
        container.addSubview(searchContainer)
        container.addConstrainsWithFormat(format: "V:|-(15)-[v0(300)]", views:searchContainer)
        container.addConstrainsWithFormat(format: "|-[v0]-|", views: searchContainer)
        
        searchContainer.addSubview(label3)
        searchContainer.addConstrainsWithFormat(format: "V:|-(5)-[v0]", views: label3)
        label3.centerXAnchor.constraint(equalTo: searchContainer.centerXAnchor).isActive = true
        
        searchContainer.addSubview(inputContainer)
        searchContainer.addConstrainsWithFormat(format: "V:[v0]-(15)-[v1(50)]", views: label3, inputContainer)
        searchContainer.addConstrainsWithFormat(format: "|-(5)-[v0]-(5)-|", views: inputContainer)
        
        inputContainer.addSubview(inputStack)
        inputContainer.addConstrainsWithFormat(format: "V:|-[v0]-|", views: inputStack)
        inputContainer.addConstrainsWithFormat(format: "|-[v0]-|", views: inputStack)
        
        inputStack.addArrangedSubview(txtSearch)
        inputStack.addArrangedSubview(btSearch)
        
        btSearch.widthAnchor.constraint(equalTo: btSearch.heightAnchor).isActive = true
        
        searchContainer.addSubview(resultContainer)
        resultContainer.heightAnchor.constraint(equalToConstant: 160).isActive = true
        resultTop = resultContainer.topAnchor.constraint(equalTo: inputContainer.bottomAnchor, constant: 15)
        resultTop?.isActive = true
        
        searchContainer.addConstrainsWithFormat(format: "|-[v0]-|", views: resultContainer)
        
        resultContainer.addSubview(labelShopname)
        resultContainer.addSubview(btOk)
        
        resultContainer.addConstrainsWithFormat(format: "|-(10)-[v0]-(10)-|", views: labelShopname)
        labelShopname.centerYAnchor.constraint(equalTo: resultContainer.centerYAnchor, constant: -30).isActive = true
        
        btOk.centerXAnchor.constraint(equalTo: resultContainer.centerXAnchor, constant: 0).isActive = true
        btOk.widthAnchor.constraint(equalToConstant: 150).isActive = true
        resultContainer.addConstrainsWithFormat(format: "V:[v0(40)]-(10)-|", views: btOk)
        
        searchContainer.addSubview(labelFinding)
        labelFinding.topAnchor.constraint(equalTo: inputContainer.bottomAnchor, constant: 15).isActive = true
        labelFinding.centerXAnchor.constraint(equalTo: inputContainer.centerXAnchor).isActive = true
    }
    
}
