//
//  VCBase.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 25/10/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import UIKit

class VCBase: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private var closeButton: UIButton = {
        let v = UIButton()
        v.useAL()
        v.setImage(#imageLiteral(resourceName: "close_icon_white"), for: .normal)
        v.contentMode = .scaleToFill
        let padding:CGFloat = 8
        v.imageEdgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        return v
    }()
    
    private var bg: UIImageView = {
        let v = UIImageView()
        v.useAL()
        v.contentMode = .scaleToFill
        return v
    }()
    
    private var fillTop: UIView = {
        let v = UIView()
        v.useAL()
        v.backgroundColor = kColorPrimary
        
        return v
    }()
    
    private var label: UILabel = {
        let v = UILabel()
        v.useAL()
        v.font = UIFont(name: MAIN_FONT_NAME, size: 22)
        v.textColor = .white
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        hideKeyboardWhenTappedAround()
    }
    
    func setupView(){
        view.backgroundColor = .white

        addBackground()
        addCloseButton()
        addLabel()
       
    }
    
    private func addBackground(){
        view.addSubview(fillTop)
        view.addSubview(bg)
        
        NSLayoutConstraint.activate([
            
            fillTop.topAnchor.constraint(equalTo: view.topAnchor),
            fillTop.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            fillTop.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fillTop.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            bg.topAnchor.constraint(equalTo: fillTop.bottomAnchor),
            bg.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bg.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bg.heightAnchor.constraint(equalToConstant: 10)
            
        ])
    }

    private func addCloseButton(){
        view.addSubview(closeButton)
        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeButtonHandle)))
        
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: -2),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor)
        ])
        
    }
    @objc func closeButtonHandle(){ self.dismiss(animated: true, completion: nil) }
    
    private func addLabel(){
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setTitleText(text:String){
        label.text = text
    }
    
    func addRootView(v: UIView){
        v.useAL()
        view.addSubview(v)
        NSLayoutConstraint.activate([
            v.topAnchor.constraint(equalTo: bg.bottomAnchor),
            v.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            v.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            v.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
