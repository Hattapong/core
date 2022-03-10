

import UIKit

class ContactView: CustomView {
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var telView: RoundUIView!
    @IBOutlet weak var fbView: RoundUIView!
    @IBOutlet weak var lineView: RoundUIView!
    @IBOutlet weak var txtWelcome: UILabel!
    @IBOutlet weak var txtTel: UILabel!
    @IBOutlet weak var txtFB: UILabel!
    @IBOutlet weak var txtLine: UILabel!
    
    override func commonInit(){
        
        loadNib(String(describing: ContactView.self))
        addEmbedView(contentView: contentView)
        
        initView()
        setupGesture()
    }
    
    func initView() {
        
        if appContext == nil {
            AppData.getAppData {
                self.setViewValue()
            }
        }
        else {
            setViewValue()
        }
        
        
    }
    
    
    // MARK: -  setup view value
    func setViewValue() {
        let defaultLogo = getLogoImage()
        logoImage.image = logoContext == nil ? defaultLogo : logoContext
        txtWelcome.text = "\(getShopNameText())"
        txtTel.text = "\(getShopTelText())"
        txtFB.text = "\(getShopFacebookText())"
        txtLine.text = "\(getShopLineText())"
    }
    
    
    func setupGesture(){
        let telGesture = UITapGestureRecognizer(target: self, action: #selector (self.telTouch(sender:)))
        telView.addGestureRecognizer(telGesture)
        
        let fbGesture = UITapGestureRecognizer(target: self, action: #selector (self.fbTouch(sender:)))
        fbView.addGestureRecognizer(fbGesture)
        
        let lineGesture = UITapGestureRecognizer(target: self, action: #selector (self.lineTouch(sender:)))
        lineView.addGestureRecognizer(lineGesture)
    }

     @objc func telTouch(sender:UITapGestureRecognizer){
         let telUrl = "tel://" + (appContext?.tel?.removeNonNumber() ?? "")
         guard let url = NSURL(string: telUrl) else  { return }
          
          UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
      }
     
      
      @objc func fbTouch(sender:UITapGestureRecognizer){
         guard appContext?.facebook != nil else {
             return
         }
         guard let url = URL(string: (appContext?.facebook)!) else  { return }
          
          UIApplication.shared.open(url, options: [:], completionHandler: nil)
      }
      
      
      @objc func lineTouch(sender:UITapGestureRecognizer){
         let lineIdUrl = "http://line.me/ti/p/~" + (appContext?.lineId ?? "")
         guard let url = URL(string: lineIdUrl) else  { return }
          
          UIApplication.shared.open(url, options: [:], completionHandler: nil)
      }
    
    
    
}
