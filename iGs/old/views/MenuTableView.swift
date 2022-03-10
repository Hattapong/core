
import UIKit

class MenuTableView: UIView {
    
   
    var items:[SubMenuItemContent] = []
    var delegate: MenuDelegate? = nil
    
    var table: UITableView = {
        let v = UITableView()
        v.backgroundColor = UIColor.clear
        v.separatorStyle = .none
        v.allowsSelection = false
        v.rowHeight = 60
        return v
    }()
    
    var headTitle: UILabel = {
        let v = UILabel()
        v.text = ""
        return v
    }()
    
    var logoWrapper:UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }()
    
    var logoWrapperBg: UIImageView = {
        let v = UIImageView()
        v.image = #imageLiteral(resourceName: "bg_home_top")
        v.contentMode = .scaleToFill
        return v
    }()
    
    var logo:UIImageView = {
        let v = UIImageView()
        v.image = getLogoImage()
        v.contentMode = .scaleAspectFit
        return v
    }()
   
    //initWithFrame to init view from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //common func to init our view
    private func setupView() {
        backgroundColor = .red
        
        addSubview(table)
        addSubview(headTitle)
        addSubview(logoWrapper)
        
        headTitle._top_to_top(self, 5)
            ._h(30)
            .useAL()
        headTitle.centerXAnchor
            .constraint(equalTo: self.centerXAnchor)
            .isActive = true
       
        table._to_left(8)
            ._to_right(-8)
            ._to_bot(0)
            ._top_to_bot(logoWrapper, 20)
            .useAL()
        
        logoWrapper._to_top(0)
            ._to_left(0)
            ._to_right(0)
//            ._h(300)
            .useAL()
        
        logoWrapper.addSubview(logoWrapperBg)
        logoWrapper.addSubview(logo)
        
        logo._to_top(20)
            ._to_bot(-40)
            ._h(130)
            ._cenX()
            .useAL()
        
        logo.widthAnchor.constraint(equalTo: logo.heightAnchor).isActive = true
        
        
        logoWrapperBg._to_top(0)
            ._to_bot(0)
            ._to_left(0)
            ._to_right(0)
            .useAL()
        
        setupTable()
    }
    
    
    private func setupTable() {
    
        table.dataSource = self
        table.delegate = self
    
        table.register(MenuTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
}

extension MenuTableView : MenuTableViewCellDelegate {
    func select(tag: MenuTags) {
        if let d = delegate {
         
            d.menuDidSelect(tag: tag)
        }
    }
}


extension MenuTableView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MenuTableViewCell
        
        cell.content = items[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}

