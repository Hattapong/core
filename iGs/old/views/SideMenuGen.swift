
import UIKit

class SideMenuGen: NSObject {
    
    var containerView : UIView = {
        let v = UIView()
        
        return v
    }()
    
    var backdropView : UIView = {
        let v = UIView()
        v.backgroundColor = .black
        return v
    }()
    
    var menuView : UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
  
    var userImage: UIImageView = {
        let img = UIImageView(image: getLogoImage()) //UIImageView(image: getLogoImage())
        
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    var nameLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont(name: MAIN_FONT_NAME, size: 30)
        l.text = "<user-name>"
        l.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return l
    }()
    
    var custidLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont(name: MAIN_FONT_NAME, size: 24)
        l.text = "<user-id>"
        l.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return l
    }()
    
    var line: UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        v.layer.cornerRadius = 1
        return v
    }()
    
    var table: UITableView = {
        let t = UITableView(frame: .zero, style: .plain)
        t.separatorStyle = .none
        return t
    }()
    
    var menuItems: [MenuItem] = {
        let items:[MenuItem] = [
            MenuItem(name: "home", text: "หน้าแรก", tag: .home),
            MenuItem(name: "saving-gold", text: "ออมทอง", tag: .doSaving),
            MenuItem(name: "goldsaving-list", text: "ประวัติออมทอง", tag: .gsHistory),
            MenuItem(name: "interest-list", text: "ส่งดอก(ขายฝาก)", tag: .doInterest),
            MenuItem(name: "pawn-list", text: "ประวัติการขายฝาก", tag: .pawnHistory),
            MenuItem(name: "contact", text: "ติดต่อเรา", tag: .contact),
            MenuItem(name: "change_password", text: "เปลี่ยนรหัสผ่าน", tag: .changePassword),
            MenuItem(name: "logout", text: "ออกจากระบบ", tag: .logout(prompting: true))
        ]
        
        return items
    }()
    
    var delegate: MenuDelegate? = nil
    
    let cellId = "cell"
    //var delegate: MenuSelectDelegate? = nil
    
    func initialState(window:UIWindow){
        containerView.frame
            = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
        backdropView.alpha = 0
        
        let w = window.frame.width * 0.7
        menuView.frame = CGRect(x: -w, y: 0, width: w, height: window.frame.height)
    }
    
    func showingState(window:UIWindow){
        backdropView.alpha = 0.4
        let w = window.frame.width * 0.7
        menuView.frame = CGRect(x: 0, y: 0, width: w, height: window.frame.height)
    }
    
    func showMenu(){
        
        if let profile = userContext {
            nameLabel.text = profile.custname
            custidLabel.text = "รหัส: \(profile.custid)"
        }
        
        
        
        if let window = keyWindow {
            
            initialState(window: window)
            
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: .greatestFiniteMagnitude, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                
                self.showingState(window: window)
                
            }, completion: nil)
            window.addSubview(containerView)
        }
        
    }
    
    @objc func handlerClose() {
        
        UIView.animate(withDuration: 0.5) {
            if let window = keyWindow {
                
                self.initialState(window: window)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.containerView.removeFromSuperview()
                }
                
            }
        }
    }
    
    override init() {
        super.init()
        
        containerView.addSubview(backdropView)
        containerView.addSubview(menuView)
       
       
        menuView.addSubview(userImage)
        menuView.addSubview(nameLabel)
        menuView.addSubview(custidLabel)
        menuView.addSubview(line)
        menuView.addSubview(table)
        
        containerView.addConstrainsWithFormat(format: "H:|[v0]|", views: backdropView)
        containerView.addConstrainsWithFormat(format: "V:|[v0]|", views: backdropView)
        
        
        
        menuView.addConstrainsWithFormat(format: "V:|-(50)-[v0(125)]-(40)-[v1]-[v2]", views: userImage, nameLabel, custidLabel)
        //menuView.addConstrainsWithFormat(format: "H:[v0(125)]", views: userImage)
        
        menuView.addConstrainsWithFormat(format: "V:[v0]-[v1(2)]-[v2]-|", views:custidLabel, line, table)
        menuView.addConstrainsWithFormat(format: "|-[v0]-|", views: line)
        menuView.addConstrainsWithFormat(format: "|-(0)-[v0]-(0)-|", views: table)
        
        NSLayoutConstraint.activate([
           
            userImage.heightAnchor.constraint(equalTo: userImage.widthAnchor),
            userImage.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            custidLabel.centerXAnchor.constraint(equalTo: menuView.centerXAnchor)
        ])
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handlerClose))
        backdropView.addGestureRecognizer(gesture)
        
        //btClose.addTarget(self, action: #selector(handlerClose), for: .touchUpInside)
        
                table.delegate = self
                table.dataSource = self
        
                table.register(MenuItemCell.self, forCellReuseIdentifier: cellId)
        
    }
}

extension SideMenuGen : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MenuItemCell
        cell.menuItem = menuItems[indexPath.row]

        cell.layoutIfNeeded()

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        handlerClose()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let delegate = self.delegate,let tag = self.menuItems[indexPath.row].tag {
                delegate.menuDidSelect(tag: tag)
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    
}
class MenuItem: NSObject {
    var name : String
    var text : String
    var tag : MenuTags?
    
    init(name:String, text:String, tag:MenuTags?) {
        
        self.name = name
        self.text = text
        self.tag = tag
    }
}
class MenuItemCell: UITableViewCell {

    
    var menuItem: MenuItem? = MenuItem(name: "name", text: "text", tag: nil) {
        didSet {
            if let item = menuItem {
                nameLabel.text = item.text
                nameLabel.sizeToFit()
            }
        }
    }

    var nameLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont(name: MAIN_FONT_NAME, size: 22)
        l.useAL()
        l.textColor = MAIN_FONT_COLOR
        l.text = "<menu-item>"
        return l
    }()
    
    var backView : UIView = {
        let v = UIView()
        v.useAL()
        v.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.2525149829)
        v.layer.cornerRadius = 20
        return v
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //contentView.backgroundColor = UIColor.black
        selectionStyle = .none
        
        contentView.addSubview(backView)
        contentView.addSubview(nameLabel)
    
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            backView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 2),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: -20),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
