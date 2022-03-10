//
//  sbFirstVC.swift
//  GoldSavingSTD-ios
//
//  Created by  Quark301 on 13/11/2562 BE.
//  Copyright © 2562  Quark301. All rights reserved.
//

import UIKit
import Alamofire
import ProgressHUD

class StartupVC: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var labStatus: UILabel!
    @IBOutlet weak var btTryAgain: UIButton!
    @IBOutlet weak var shopLogo: UIImageView!
    
    let strLoading:String = "กำลังติดต่อเซิฟเวอร์..."
    let strFail:String = "ไม่สามารถติดต่อเซิฟเวอร์ได้"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadComponent()
        
    }
    
    
    
    func initView() {
        labStatus.text = strLoading
        btTryAgain.isHidden = true
        
    }
    
    func loadComponent(){
        
        initView()
        
        fetchLogo {
            
            self.shopLogo.image = getLogoImage()
            
            self.fetchAppData {
                self.loadNextView()
            }
        }
    }
    
    @IBAction func tryAgain(_ sender: Any) {
        
        loadComponent()
        
    }
    
    
    func fetchAppData(then: @escaping ()-> Void) {
        
        AppData.getAppData {
            
            guard appContext != nil else {
                self.labStatus.text = self.strFail
                self.btTryAgain.isHidden = false
                return self.onError()
            }
            
            then()
            
        }
    }
    
    func fetchLogo(then: @escaping ()-> Void) {
        AF.download(Router.appLogo).responseData { response in
            switch response.result {
            case .success(let data):
                setLogoImage(logo: UIImage(data: data))
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            then()
        }
    }
    
    
    func loadNextView(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "login")
        vc?.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        vc?.modalTransitionStyle = .crossDissolve
        if vc != nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.show(vc!, sender: nil)
            }
        }
    }
    
    let onError: ()-> Void = {
        
        print("...")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
}
