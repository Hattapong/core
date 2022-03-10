//
//  ViewExtension.swift
//  GoldSavingSTD-ios
//
//  Created by  Quark301 on 10/10/2562 BE.
//  Copyright © 2562  Quark301. All rights reserved.
//

import UIKit
import ProgressHUD
import PopupDialog

extension UIButton {
    
    func applyPrimaryStyle( withTitle _title:String) {
        
        self.setTitle(_title, for: .normal)
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.setTitleColor(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1), for: .normal)
        self.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .selected)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 3
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        
    }
    func applyUnSelectStyle() {
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.setTitleColor(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1), for: .normal)
    }
    func applySelectStyle() {
        self.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        self.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) ,for: .normal)
        self.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) ,for: .selected)
        print(self.state)
    }
    
    func applyRoundStyle(withBackground color: UIColor) {
        
        self.backgroundColor = color
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.layer.cornerRadius = 5
    }
    
    func setDefaultStyle() {
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        self.layer.cornerRadius = 5
        
        //self.titleLabel!.font = UIFont.systemFont(ofSize: 40)
        self.titleLabel?.textColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
    }
}


extension UIView {
    
    func setShadow(radius:CGFloat = 10){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = radius
    }
    
    func toast(message: String){
//        self.makeToast(message, duration: 1.5, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
        
        ProgressHUD.show(message, icon: .question, interaction: false)
    }
    
    func applyRoundStyle() {
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        self.layer.cornerRadius = 5
    }
    
    func useAL() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func _left_to_left(_ of:UIView , _ constant:CGFloat) -> UIView {
        self.leadingAnchor.constraint(equalTo: of.leadingAnchor, constant: constant).isActive = true
        return self
    }
    
    func _left_to_right(_ of:UIView , _ constant:CGFloat) -> UIView {
        self.leadingAnchor.constraint(equalTo: of.trailingAnchor, constant: constant).isActive = true
        return self
    }
    
    func _right_to_left(_ of:UIView , _ constant:CGFloat) -> UIView {
        self.trailingAnchor.constraint(equalTo: of.leadingAnchor, constant: constant).isActive = true
        return self
    }
    
    func _right_to_right(_ of:UIView , _ constant:CGFloat) -> UIView {
        self.trailingAnchor.constraint(equalTo: of.trailingAnchor, constant: constant).isActive = true
        return self
    }
    
    func _top_to_top(_ of:UIView , _ constant:CGFloat) -> UIView {
        self.topAnchor.constraint(equalTo: of.topAnchor, constant: constant).isActive = true
        return self
    }
    
    func _top_to_bot(_ of:UIView , _ constant:CGFloat) -> UIView {
        self.topAnchor.constraint(equalTo: of.bottomAnchor, constant: constant).isActive = true
        return self
    }
    
    func _bot_to_bot(_ of:UIView , _ constant:CGFloat) -> UIView {
        self.bottomAnchor.constraint(equalTo: of.bottomAnchor, constant: constant).isActive = true
        return self
    }
    
    func _bot_to_top(_ of:UIView , _ constant:CGFloat) -> UIView {
        self.bottomAnchor.constraint(equalTo: of.topAnchor, constant: constant).isActive = true
        return self
    }
    
    func _w(_ constant:CGFloat) -> UIView{
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    func _h(_ constant:CGFloat) -> UIView{
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    func _to_top(_ constant:CGFloat?) -> UIView{
        self.topAnchor
            .constraint(equalTo: superview!.topAnchor, constant: constant ?? 0)
            .isActive = true
        return self
    }
    func _to_bot(_ constant:CGFloat?) -> UIView{
        self.bottomAnchor
            .constraint(equalTo: superview!.bottomAnchor, constant: constant ?? 0)
            .isActive = true
        return self
    }
    func _to_left(_ constant:CGFloat?) -> UIView{
        self.leftAnchor
            .constraint(equalTo: superview!.leftAnchor, constant: constant ?? 0)
            .isActive = true
        return self
    }
    func _to_right(_ constant:CGFloat?) -> UIView{
        self.rightAnchor
            .constraint(equalTo: superview!.rightAnchor, constant: constant ?? 0)
            .isActive = true
        return self
    }
    
    func _cenX() -> UIView{
        self.centerXAnchor
            .constraint(equalTo: superview!.centerXAnchor)
            .isActive = true
        return self
    }
    
    func _cenY() -> UIView{
        self.centerYAnchor
            .constraint(equalTo: superview!.centerYAnchor)
            .isActive = true
        return self
    }
    
   
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func forcePromptDialog(title: String, message: String, completion:(()->Void)?){
        
        let popup = PopupDialog(title: title, message: message, tapGestureDismissal: false, panGestureDismissal: false)
        
        let popupFont = UIFont(name: kFFPrimary, size: 24)!
        
        let btn = DefaultButton(title: "ตกลง") {
            if let completion = completion { completion() }
        }
        
        btn.titleFont = popupFont
        btn.titleColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        popup.addButtons([btn])
        let vc = popup.viewController as! PopupDialogDefaultViewController
                vc.titleFont = popupFont
                vc.messageFont = popupFont
        
        
        self.present(popup, animated: true, completion: {
            
        })
        
        
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func useDefaultStyles() -> UIViewController {
        self.modalPresentationStyle = .fullScreen
        self.modalTransitionStyle = .crossDissolve
        return self
    }
    
    func showLegacyToast(message: String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message,
                                      preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + seconds ) {
            alert.dismiss(animated: true)
        }
    }
    func showLegacyToastShort(message: String) {
        let alert = UIAlertController(title: nil, message: message,
                                      preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + 0.75 ) {
            alert.dismiss(animated: true)
        }
    }
    
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ตกลง", style: UIAlertAction.Style.cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func showAlert(title:String, message:String,ifOk:(() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ตกลง", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: ifOk)
        }))
        alert.addAction(UIAlertAction(title: "ยกเลิก", style: UIAlertAction.Style.cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
//    func showToast(message: String, seconds: Double) {
//        let alert = UIAlertController(title: nil, message: message,
//                                      preferredStyle: .alert)
//        alert.view.backgroundColor = UIColor.black
//        alert.view.alpha = 0.6
//        alert.view.layer.cornerRadius = 15
//        present(alert, animated: true)
//        
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
//            alert.dismiss(animated: true)
//        }
//    }

}
extension UIScrollView {

    // Scroll to a specific view so that it's top is at the top our scrollview
    func scrollToView(view:UIView, animated: Bool, constance: CGFloat) {
        if let origin = view.superview {
            // Get the Y position of your child view
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
            self.scrollRectToVisible(CGRect(x:0, y:childStartPoint.y - constance ,width: 1,height: self.frame.height), animated: animated)
        }
    }

    // Bonus: Scroll to top
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }

    // Bonus: Scroll to bottom
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }

}
