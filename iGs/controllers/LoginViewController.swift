

import UIKit
import Alamofire
import ProgressHUD

class LoginViewController: UIViewController{
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var inputPanView: UIView!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var btLogin: UIButton!
    
    @IBOutlet weak var usernameWrap: UIView!
    @IBOutlet weak var passwordWrap: UIView!
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var usernameBottom: NSLayoutConstraint!
    @IBOutlet weak var passwordBottom: NSLayoutConstraint!
    
    @IBOutlet weak var lineLinkButton: UIButton!
    @IBOutlet weak var txtFooter: UILabel!
    
    var saveLogin = true
    let credential = CredentialServerice(server: apiUrlBase)
    var preventAutoLogin = false // set to true when logout
    
    let bypasss = false
    
    
    
    // MARK: -  View Loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        setupView()
        
        
        
        if bypasss {
            bypassLogin()
        }
        
        
        restoreCredentials()
    }
    
    // MARK: -  setup view
    private func setupView() {
        
        usernameWrap.round(color: kColorPrimaryDark, width: 2.0, radius: 20.0)
        passwordWrap.round(color: kColorPrimaryDark, width: 2.0, radius: 20.0)
        
        lineLinkButton.round(color: kColorPrimary, width: 2, radius: 20.0)
        
        usernameField.delegate = self
        passwordField.delegate = self
        btLogin.layer.cornerRadius = 15
        logoImg.image = getLogoImage()
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    // MARK: -  Credential Manage
    
    func restoreCredentials(){
        
        if let credentials = credential.getCredentials() {
            
            usernameField.becomeFirstResponder()
            usernameField.text = credentials.username
            
            passwordLabel.becomeFirstResponder()
            passwordField.text = credentials.password
            
            if !preventAutoLogin {
                login()
            }
        }
        
        
    }
    
    
    func storeCredentialIfNeed(){
        
        guard saveLogin else {
            return
        }
        
        credential.saveCredentials(username: usernameField.text!, password: passwordField.text!)
    }
    
    
    
    
    
    // MARK: -  Do Login
    @IBAction func login_switch_change(_ sender: Any) {
        let _switch = sender as! UISwitch
        saveLogin = _switch.isOn
    }
    
    func populateFooter(){
        if let appdata = appContext {
            txtFooter.text  = "\(appdata.shopName ?? "")\nTel:\(appdata.tel ?? "")\nสอบถามการใช้งานโปรแกรม กรุณาติดต่อทางร้าน"
        }
    }
    
    @IBAction func handleLogin(_ sender: UIButton) {
        login()
    }
    
    
    func login(){
        credential.clearCredentials()
        Auth.sharedInstance().token = nil
        
        ProgressHUD.animationType = .systemActivityIndicator
        ProgressHUD.show()
        btLogin.isEnabled = false
        
        fetchLogin {
            
            self.btLogin.isEnabled = true
            //ProgressHUD.dismiss()
        }
    }
    
    func fetchLogin(completed:(() -> Void)?) {
        let router = Router.login(username: usernameField.text!, password: passwordField.text!)
        AF.request(router).validate().responseString(completionHandler: { (response) in
            switch response.result {
            case .success: self.handleLoginSuccess(response)
            case .failure: self.handleLoginError();
            }
            
            if let completed = completed {
                completed()
            }
        })
    }
    
    func handleLoginSuccess(_ response:AFDataResponse<String>){
        let token = response.value?.removeQuote()
        Auth.sharedInstance().token = token
        
        guard Auth.sharedInstance().token != nil else { self.handleLoginError(); return }
        self.fetchUserData()
        
    }
    
    func handleLoginError() {
        self.view.toast(message: "ข้อมูลล็อกอินไม่ถูกต้อง")
    }
    
    
    
    
    func bypassLogin(){
        
        usernameField.text = "c005589"
        passwordField.text = "2412"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            self.login()
        }
        
    }
    
    // MARK: -  fetch user data
    
    func fetchUserData() {
        let router = Router.userProfile
        AF.request(router).validate().responseJSON { (response) in
            switch response.result {
            case .success: self.handleUserDataLoaded(response)
            case .failure(let error): self.handleAFError(error)
            }
        }
    }
    
    func handleUserDataLoaded(_ response:AFDataResponse<Any>){
        do {
            
            storeCredentialIfNeed()
            
            let decoder = JSONDecoder()
            let model = try decoder.decode(UserProfile.self, from:
                                            response.data!) //Decode JSON Response Data
            userContext = model
            self.presentHome()
            
        } catch let parsingError {
            print("Error", parsingError)
        }
    }
    func handleAFError(_ error: AFError){
        self.view.toast(message: "ข้อมูลบัญชีไม่ถูกต้อง โปรดติดต่อทางร้าน")
    }
    
    @IBAction func register_click(_ sender: Any) {
        //        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "bankAccountInfo") else { self.handleLoginError(); return }
        //        vc.modalPresentationStyle = .fullScreen
        //        vc.modalTransitionStyle = .crossDissolve
        //        self.present(vc, animated: true, completion: nil)
        
    }
    
    // MARK: -  Naviagate
    func presentHome() {
        let vc = MainViewController().useDefaultStyles()
        self.present(vc, animated: true, completion: nil)
    }
    
    
}


// MARK: -  TextField Setup

extension LoginViewController : UITextFieldDelegate  {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == usernameField {
            animateBeginEdit(textField: textField, label: usernameLabel, constraint: usernameBottom)
            
        }
        
        if textField == passwordField {
            animateBeginEdit(textField: textField, label: passwordLabel, constraint: passwordBottom)
            
        }
        
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == usernameField && textField.text?.count == 0 {
            
            animateEndEdit(textField: textField, label: usernameLabel, constraint: usernameBottom)
            
        }
        
        if textField == passwordField && textField.text?.count == 0 {
            animateEndEdit(textField: textField, label: passwordLabel, constraint: passwordBottom)
            
        }
    }
    
    
    func animateBeginEdit(textField:UITextField, label:UILabel, constraint:NSLayoutConstraint) {
        
        constraint.constant = 45
        UIView.animate(withDuration: 0.3) {
            label.font = UIFont(name: kFFPrimary, size: 18)
            textField.superview?.layoutIfNeeded()
        }
        
    }
    
    func animateEndEdit(textField:UITextField, label:UILabel, constraint:NSLayoutConstraint) {
        
        constraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            label.font = UIFont(name: kFFPrimary, size: 24)
            textField.superview?.layoutIfNeeded()
        }
        
    }
}


