//
//  Indicator.swift
//  iGs
//
//  Created by Hattapong on 14/1/2564 BE.
//

import UIKit

class Indicator: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var onTapNext = {}
    var onTapPrev = {}
    
    @objc func handleNextTap() {
        onTapNext()
    }
    
    @objc func handlePrevTap() {
        onTapPrev()
    }
    
    func setupView() {
        backgroundColor = .clear
        
        addSubview(stMain)
        addConstrainsWithFormat(format: "H:|-0-[v0]-0-|", views: stMain)
        addConstrainsWithFormat(format: "V:|-0-[v0]-0-|", views: stMain)
        
        let separator0 = UIView()
        separator0.useAL()
        
        stMain.addArrangedSubview(btnPrev)
        stMain.addArrangedSubview(separator0)
        stMain.addArrangedSubview(btnNext)
        stMain.addConstrainsWithFormat(format: "H:[v0(30)]", views: btnPrev)
        stMain.addConstrainsWithFormat(format: "V:[v0(30)]", views: btnPrev)
        stMain.addConstrainsWithFormat(format: "H:[v0(30)]", views: btnNext)
        stMain.addConstrainsWithFormat(format: "V:[v0(30)]", views: btnNext)
        
        
        btnPrev.addTarget(self, action: #selector(handlePrevTap), for: .touchUpInside)
        btnNext.addTarget(self, action: #selector(handleNextTap), for: .touchUpInside)
    }
    
    private var stMain:UIStackView = {
        let v = UIStackView()
        v.useAL()
        v.alignment = .center
        v.axis = .horizontal
        v.distribution = .fill
        return v
    }()
    
    var btnNext: UIButton = {
        let v = UIButton()
        v.setImage(UIImage(systemName: "arrow.right")?.withRenderingMode(.alwaysTemplate), for: .normal)
        v.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5199968957)
        return v
    }()
    
    var btnPrev: UIButton = {
        let v = UIButton()
        v.setImage(UIImage(systemName: "arrow.left")?.withRenderingMode(.alwaysTemplate), for: .normal)
        v.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5199968957)
        return v
    }()
}
