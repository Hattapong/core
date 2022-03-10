
import UIKit

class SavingTypeDialog: NSObject, UIGestureRecognizerDelegate  {
    
    enum Result {
        case yes, no
    }
    
    var keywindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
   
    var msg:String
    var ans1:String
    var ans2:String
    
    
    var onSelected: ((_ result:Result)->Void)? = nil
    

    lazy var boxHeight:CGFloat = {
        return 200
    }()
    
    
    lazy var disappearBoxTop : CGFloat = {
        if let window = self.keywindow {
            return window.safeAreaInsets.top + 100
        }
        
        return 0.0
    }()
    lazy var appearedBoxTop : CGFloat = {
        
        if let window = self.keywindow {
            return window.safeAreaInsets.top + 140
        }
        
        return 0.0
    }()
    
    init(message: String, answerI:String, answerII:String) {
        
        self.msg = message
        self.ans1 = answerI
        self.ans2 = answerII
        super.init()
        
                
        if let window = keywindow {
           
            window.addSubview(rootView)
            
            rootView.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
            rootView.alpha = 0
            
            rootView.addSubview(contentView)
            contentView.frame = CGRect(x: 8, y: self.disappearBoxTop, width: window.frame.width - (8 * 2), height: boxHeight)
            
            contentView.alpha = 0
            
            contentView.addSubview(stk1)
            
            stk1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
            stk1.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
            stk1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
            stk1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
            
            stk1.addArrangedSubview(titleText)
            stk1.addArrangedSubview(stk2)
            stk2.addArrangedSubview(btnNo)
            stk2.addArrangedSubview(btnYes)
            
            btnYes.addTarget(self, action: #selector(btnYesTap), for: .touchUpInside)
            btnNo.addTarget(self, action: #selector(btnNoTap), for: .touchUpInside)
        }
    }
    
    override convenience init() {
        self.init(message: "", answerI:"", answerII:"")
    }
    
    
    func show(){
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut) {
            if let window = self.keywindow {
            self.rootView.alpha = 1
            
                self.contentView.frame = CGRect(x: 8, y:self.appearedBoxTop, width: window.frame.width - (8 * 2), height: self.boxHeight)
            
            self.contentView.alpha = 1
            }
        } completion: { (_) in
            
        }

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleHide))
        tap.delegate = self
        self.rootView.addGestureRecognizer(tap)
    }
    
    func hide(){
      
           
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
                self.rootView.alpha = 0
            } completion: { (_) in
                self.rootView.removeFromSuperview()
            }

        
    }
    
    func setStyle(view v: UIButton){
        v.layer.cornerRadius = 15
        v.layer.borderWidth = 2
        v.layer.borderColor = kColorPrimary.cgColor
        v.setTitleColor(kColorPrimary, for: .normal)
        v.titleLabel?.font  = UIFont(name: kFFPrimary, size: 24)
        v.backgroundColor =   kColorSecondary
        v.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    @objc func handleHide(){
        hide()
    }
    
    @objc func btnYesTap(){
        onSelected?(Result.yes)
        hide()
    }
    
    @objc func btnNoTap(){
        onSelected?(Result.no)
        hide()
    }
    
    // REMARK :- view
    
    lazy var rootView:UIView = {
        let v = UIView()
        v.backgroundColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1789322405)
    
        return v
    }()
    
    lazy var contentView: UIView = {
        let v = UIView()
        //v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.cornerRadius = 5
        v.layer.borderWidth = 2
        v.layer.borderColor = kColorPrimary.cgColor
        v.setShadow()
        return v
    }()
    
    lazy var stk1: UIStackView = {
        let v = UIStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .vertical
        v.distribution = .fillEqually
        v.alignment = .fill
        return v
    }()
    
    lazy var stk2: UIStackView = {
        let v = UIStackView()
        v.axis = .horizontal
        v.distribution = .fillEqually
        v.alignment = .center
        v.spacing = 10
        return v
    }()
    
    lazy var titleText: UILabel = {
        let v = UILabel()
        v.text = msg
        v.font = UIFont(name: MAIN_FONT_NAME, size: 28)
        v.textColor = kColorPrimary
        v.textAlignment = .center
        return v
    }()
    
    lazy var btnYes:UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setTitle(ans2, for: .normal)
        setStyle(view: v)
        return v
    }()
    
    lazy var btnNo:UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setTitle(ans1, for: .normal)
        setStyle(view: v)
        return v
    }()
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
    
//    func handleTapOffModal(_ sender: UITapGestureRecognizer) {
//        //dismiss(animated: true, completion: nil)
//    }
    
    
    
}
