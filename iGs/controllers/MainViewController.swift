

import Foundation

import  UIKit
import PopupDialog

class MainViewController: UIViewController {

    // MARK: - override
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        populatePageViews()
        setupView()
    }
    
    
    // MARK: - member
    let pages = [
        ChildPages.main,
        ChildPages.histoty,
        ChildPages.transaction,
        ChildPages.contact
    ]
    
    var pageViews:[UIView] = []
    
    var stripeCons:NSLayoutConstraint? = nil
    
    
    var savingTypeDialog: SavingTypeDialog!
    // MARK: - subview
    
    lazy var navbar : UIView = {
        let v = UIView()
        
        v.backgroundColor = kColorPrimary
        
        return v
    }()
    
    lazy var btnMenu : UIButton = {
        let v = UIButton(type: .system)
        v.setImage(#imageLiteral(resourceName: "icon_menu"), for: .normal)
        v.tintColor = .white
        
        return v
    }()
          
    lazy var bottomBar: UIView = {
        let v = UIView()
        
        v.backgroundColor = .black.withAlphaComponent(0.3)
        v.round(color: .clear, width: 0, radius: 10)
        v.clipsToBounds = true
        
        let blur = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = v.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        v.addSubview(blurView)
        return v
    }()
    
    
    lazy var bottomBarStack: UIStackView = {
        let v = UIStackView(frame: .zero)
        v.axis = .horizontal
        v.alignment = .fill
        v.distribution = .fillEqually
        
        return v
    }()
    
    lazy var backgroundImage: UIImageView = {
        let v = UIImageView(image: #imageLiteral(resourceName: "bg_gd_01"))
        
        return v
    } ()
    
    lazy var stripe: UIView = {
        let v = UIView()
        v.backgroundColor = kColorSecondaryDark
        v.isHidden = true
        return v
    }()
    
    lazy var separator: UIView = {
        let v = UIView()
        v.isHidden = true
        v.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        v.alpha = 0.5
        return v
    }()
    
    lazy var coll:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
       
        v.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
        v.dataSource = self
        v.delegate = self
        v.isPagingEnabled = true
        v.showsHorizontalScrollIndicator = false
        v.showsVerticalScrollIndicator = false
        
        v.register(ChildPageCell.self, forCellWithReuseIdentifier: "cell")
        v.register(HomeView.self, forCellWithReuseIdentifier: "homeCell")
        
        return v
    } ()
    
    
    // MARK: - Setup View (Auto layout)
    
    func setupView(){
        view.addSubview(backgroundImage)
        view.addSubview(coll)
        view.addSubview(bottomBar)
        view.addSubview(navbar)
        view.addSubview(separator)
        
        navbar.addSubview(btnMenu)
        
        navbar
        ._to_right(0)
        ._to_left(0)
        ._h(55)
        .useAL()
        
        navbar.topAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        
        
        let filltop = UIView()
        filltop.backgroundColor = kColorPrimary
        view.addSubview(filltop)
       
        filltop
            ._to_top(0)
            ._to_left(0)
            ._to_right(0)
            .useAL()
        filltop.bottomAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        
        
        
        btnMenu._to_left(8)
            ._h(48)
            ._w(48)
            ._cenY()
            .useAL()
        
        
        
        bottomBar
        ._to_right(-20)
        ._to_left(20)
        ._h(45)
        .useAL()
        
        bottomBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 5).isActive = true
        
        backgroundImage._to_top(0)
        ._to_left(0)
        ._to_right(0)
        ._to_bot(0)
        .useAL()
        
        coll._top_to_bot(navbar, 0)
        ._to_left(0)
        ._to_right(0)
        //._bot_to_top(bottomBar, 0)
        ._to_bot(0)
        .useAL()
        //coll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
       
        separator._bot_to_top(bottomBar, 0)
        ._to_left(0)
        ._to_right(0)
        ._h(1)
        .useAL()
        
        bottomBar.addSubview(bottomBarStack)
        
        bottomBarStack._to_bot(0)
        ._to_right(0)
        ._to_left(0)
        ._to_top(0)
        .useAL()
        
        for page in pages {
            let index = pages.firstIndex(of: page) ?? -1
           
            let pageView = page.creatView()
            pageView.tag = index
            pageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(navSelect)))
            bottomBarStack.addArrangedSubview(pageView)
        }
        
        bottomBar.addSubview(stripe)
        
        stripe._to_top(0)
            ._w(view.frame.width / CGFloat(pages.count))
        ._h(2)
        .useAL()
        
        
        stripeCons = stripe.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor)
        NSLayoutConstraint.activate([
            stripeCons!
        ])
        
        
        btnMenu.addTarget(self, action: #selector(onMenuClick(sender:)), for: .touchUpInside)
    }
    
    
    func populatePageViews(){
        for p in pages {
            pageViews.append(p.getPageView())
        }
    }
    
    
  
    // MARK: - action handler
    
    
    @objc func navSelect(gesture : UITapGestureRecognizer) {
        let tag = gesture.view!.tag
        //print(tag)
        scrollToMenuIndex(at: tag)
    }
    
    let sideMenu = SideMenuGen()
    
    @objc func onMenuClick(sender:Any) {
        if sideMenu.delegate == nil {
            sideMenu.delegate = self
        }
        sideMenu.showMenu()
    }
    
}

extension MainViewController  : MenuDelegate {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func menuDidSelect(tag: MenuTags) {
        
        switch tag {
        case .doSaving:
            
            // เลือกออมแบบเปิดบัญชี/ ไม่เปิดบัญญชี
            /*
            savingTypeDialog = SavingTypeDialog(message: "เลขบัญชีออมทอง", answerI: "1-2900", answerII: "2900 ขึ้นไป")
            
            savingTypeDialog.show()
            
            savingTypeDialog.onSelected = { res in
                
                let vc = SavingGold()
                vc.rootView.mode = (res == SavingTypeDialog.Result.yes) ? .byContractID : .byBranch
                self.showFullPage(vc: vc)
                
            }
            */
        
           // ออมแบบเปิดบัญชี
            let vc = SavingGold()
            vc.rootView.mode = .byBranch
            self.showFullPage(vc: vc)
            
        case .doInterest:
            let vc = InterestPawn()
            showFullPage(vc: vc)
        case .gsHistory:
            let vc = CollectionBase()
            vc.setTitleText(text: "ประวัติการออมทอง")
            vc.setCells(cells: [
                   CellTemplate(caption: "ออม", cellType: SavingListsCell.self),
                   CellTemplate(caption: "ถอน", cellType: WithdrawListCell.self),
                   CellTemplate(caption: "ใช้", cellType: SpendingListCell.self),
                   CellTemplate(caption: "รออนุมัติ", cellType: PendingListCell.self),
            
            ])
            showFullPage(vc: vc)
            
        case .pawnHistory:
            let vc = CollectionBase()
            vc.setTitleText(text: "ประวัติการขายฝาก")
            vc.setCells(cells: [
                   CellTemplate(caption: "ต่อดอก", cellType: InterestListCell.self),
                   CellTemplate(caption: "ขายฝาก", cellType: PawnListCell.self),
                   CellTemplate(caption: "รออนุมัติ", cellType: PendingPawnListCell.self),
            
            ])
            showFullPage(vc: vc)
        
        case .home : scrollToMenuIndex(at: 0)
            
        case .contact : scrollToMenuIndex(at: 3)
            
        case .changePassword:
            let vc = ChangePasswordVC()
            vc.delegate = self
            showFullPage(vc: vc)
            
        case .logout(let isPrompting):
            
            handleLogout(isPrompting)
           
        }
        
    }
    
    func handleLogout(_ isPrompting: Bool){
        if(!isPrompting) { return logout() }
        
        
        self.prompt(title: "ออกจากระบบ", message: "ต้องการออกจากระบบ?", cancel: nil) {
            self.logout()
        }
//        let title = "ออกจากระบบ"
//        let message = "ต้องการออกจากระบบ?"
//        let popup = PopupDialog(title: title, message: message)
//
//        let ok = DefaultButton(title: "ตกลง") { self.logout() }
//        ok.titleFont = UIFont(name: "Trirong-ExtraLight", size: 18)!
//        ok.titleColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
//
//        let cancel = CancelButton(title: "ยกเลิก") {}
//        cancel.titleFont = UIFont(name: "Trirong-ExtraLight", size: 18)!
//        cancel.titleColor = .red
//
//        popup.addButtons([ok, cancel])
//
//        self.present(popup, animated: true, completion: {
//        })
//
//        let vc = popup.viewController as! PopupDialogDefaultViewController
//        vc.titleFont = UIFont(name: "Trirong", size: 18)!
//        vc.messageFont = UIFont(name: "Trirong-ExtraLight", size: 18)!
        
    }
    
    func logout(){
        userContext = nil
        Auth.sharedInstance().token = nil
        CredentialServerice(server: apiUrlBase).clearCredentials()
        
        if let window = keyWindow, let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as? LoginViewController {
            vc.preventAutoLogin = true
            window.rootViewController = vc
        }
    }
    
    func showFullPage(vc: UIViewController) {
        vc.modalPresentationStyle = .fullScreen
        //vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
}

 // MARK: - collection view


extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
       return pages.count
    }
    
    func scrollToMenuIndex(at index:Int){
        self.coll.isPagingEnabled = false
        coll.scrollToItem(at: IndexPath(row: index, section: 0), at: .init(), animated: true)
        self.coll.isPagingEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let pageView = pageViews[indexPath.row]

        if pageView is HomeView {
            
            let cell = collectionView
                        .dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeView
            
            return cell
            
        } else {
            
            let cell = collectionView
                        .dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ChildPageCell
                    
                    
                    
                    pageView.backgroundColor = UIColor.clear
                    cell.setView(v: pageView)
                   
                    if pageView is MenuTableView {
                        let t  = pageView as! MenuTableView
                        t.delegate = self
                    }
                    
                    return cell

        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        stripeCons!.constant = x / CGFloat(pageViews.count) + 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height)
    }
}
