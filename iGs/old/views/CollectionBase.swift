

import UIKit

class CollectionBase : VCBase {
    
    var buttonHeight:CGFloat = 30
    
    var buttonRadius:CGFloat {
        get { return buttonHeight / 2 }
        set { buttonHeight = newValue * 2 }
    }
    
    var buttonWidth: CGFloat {
        let total = CGFloat(cells.count)
        let gap:CGFloat = 2.0
        return (view.frame.width - 16 - (gap * (total - 1))) / total
    }
    
    var cells: [CellTemplate] = []
    var buttonBackdropWidthConstraint: NSLayoutConstraint = .init()
    var buttonBackdropLeadingConstraint: NSLayoutConstraint = .init()
    
    
    
    var rootView: UIView = {
        let v = UIView()
        v.useAL()
        return v
    }()
    
    var buttonGroup: UIView = {
        let v = UIView()
        v.useAL()
        v.backgroundColor = .clear
        return v
    }()
    
    var buttonGroupStack: UIStackView = {
        let v = UIStackView()
        v.useAL()
        v.axis = .horizontal
        v.alignment = .center
        v.distribution = .fillEqually
        v.spacing = 2
        return v
    }()
    
    lazy var cv : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        v.useAL()
        v.backgroundColor = .clear
        v.dataSource = self
        v.delegate = self
        v.isPagingEnabled = true
        v.showsHorizontalScrollIndicator = false
        v.showsVerticalScrollIndicator = false
        
        v.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        for cell in cells {
            v.register(cell.cellType, forCellWithReuseIdentifier: cell.cellId)
        }
        
        return v
    }()
    
    lazy var buttonBackdrop : UIView = {
        let v = UIView()
        v.useAL()
        v.layer.cornerRadius = buttonRadius
        v.backgroundColor = kColorPrimary
       
        return v
    }()
    
    
    
    override func setupView() {
        super.setupView()
        
        buttonBackdropWidthConstraint = buttonBackdrop.widthAnchor.constraint(equalToConstant: 0)
        buttonBackdropLeadingConstraint = buttonBackdrop.leadingAnchor.constraint(equalTo: buttonGroup.leadingAnchor, constant: 8)
        
        addRootView(v: rootView)
        
        
        addSelecter()
        addCollectionView()
        
        buttonBackdropWidthConstraint.constant = buttonWidth
    }
    
    
    func addSelecter(){
        rootView.addSubview(buttonGroup)
        addHighlight()
        buttonGroup.addSubview(buttonGroupStack)
        
        NSLayoutConstraint.activate([
            buttonGroup.topAnchor.constraint(equalTo: rootView.topAnchor),
            buttonGroup.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            buttonGroup.trailingAnchor.constraint(equalTo: rootView.trailingAnchor),
            buttonGroup.heightAnchor.constraint(equalToConstant: 40),
            
            buttonGroupStack.topAnchor.constraint(equalTo: buttonGroup.topAnchor),
            buttonGroupStack.leadingAnchor.constraint(equalTo: buttonGroup.leadingAnchor, constant: 8),
            buttonGroupStack.trailingAnchor.constraint(equalTo: buttonGroup.trailingAnchor, constant: -8),
            buttonGroupStack.bottomAnchor.constraint(equalTo: buttonGroup.bottomAnchor),
        ])
        
        
        for cell in cells {

            let tag = cells.firstIndex(where: { (c:CellTemplate) -> Bool in
                return c.cellId == cell.cellId
            })!
            let button = createButton(title: cell.caption, tag: tag)
            
            buttonGroupStack.addArrangedSubview(button)
        }
        
    }
    
    func createButton(title:String, tag: Int) -> UIButton {
        let bt = UIButton()
        bt.layer.cornerRadius = buttonRadius
        bt.layer.borderColor = kColorPrimary.cgColor
        bt.layer.borderWidth = 1
        bt.backgroundColor = .clear
        bt.setTitleColor(#colorLiteral(red: 0.8156862745, green: 0.6705882353, blue: 0.368627451, alpha: 1), for: .normal)
        bt.titleLabel?.font = UIFont(name: MAIN_FONT_NAME, size: 22)
        bt.setTitle("\(title)", for: .normal)
        bt.tag = tag
        bt.addTarget(self, action: #selector(selectedHandle), for: .touchUpInside)
        bt.useAL()
        bt.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        return bt
    }
    
    func addCollectionView(){
        rootView.addSubview(cv)
        NSLayoutConstraint.activate([
            cv.topAnchor.constraint(equalTo: buttonGroup.bottomAnchor),
            cv.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            cv.trailingAnchor.constraint(equalTo: rootView.trailingAnchor),
            cv.bottomAnchor.constraint(equalTo: rootView.bottomAnchor),
        ])
    }
    
    @objc func selectedHandle(sender:UIButton){
        scrollToMenuIndex(at: sender.tag)
    }
    
    func addHighlight(){
        buttonGroup.addSubview(buttonBackdrop)
        
        NSLayoutConstraint.activate([
            buttonBackdrop.heightAnchor.constraint(equalToConstant: buttonHeight),
            buttonBackdrop.centerYAnchor.constraint(equalTo: buttonGroup.centerYAnchor),
            buttonBackdropWidthConstraint,
            buttonBackdropLeadingConstraint,
        ])
        
    }
   
    func setCells(cells: [CellTemplate]) {
        self.cells = cells
    }
}

extension CollectionBase : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
       return cells.count
    }
    
    func scrollToMenuIndex(at index:Int){
        cv.isPagingEnabled = false
        cv.scrollToItem(at: IndexPath(row: index, section: 0), at: .init(), animated: true)
        cv.isPagingEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let template = cells[indexPath.row]
        
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: template.cellId, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        
        /// จำนวนปุ่ม
        let total = CGFloat(cells.count)
        
        /// ระยะระหว่างปุ่ม
        let gap:CGFloat = 2.0
        let selectedIndex =  (scrollView.contentOffset.x / scrollView.frame.width)
                
        let selecterMargin:CGFloat = 8.0
        let lineWid = (buttonGroupStack.frame.width - (gap * (total - 1))) / total
       
        buttonBackdropWidthConstraint.constant = lineWid
        buttonBackdropLeadingConstraint.constant = selecterMargin + (selectedIndex * lineWid) + (selectedIndex * gap)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height)
    }
}

class CellTemplate {
    var caption:String
    var cellType: UICollectionViewCell.Type
    var cellId:String
    
    init(caption:String, cellType: UICollectionViewCell.Type){
        self.caption = caption
        self.cellType = cellType
        self.cellId = "".randomString(length: 10)
    }
}
