import UIKit


class MenuTableViewCell: UITableViewCell {
    
    
    var icon: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleToFill
        return v
    } ()
    
    var label: UILabel = {
        let v = UILabel()
        v.font = UIFont(name: MAIN_FONT_NAME, size: 30)
        v.textColor = MAIN_FONT_COLOR
        v.textAlignment = .center
        return v
    }()
    
    var wrapper: UIView = {
        let v  = UIView()
        
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3321650257)
        v.layer.cornerRadius = 8
        v.isUserInteractionEnabled = true
        
        return v
    }()
    
    var delegate: MenuTableViewCellDelegate? = nil
    
    var content: SubMenuItemContent? = nil
    {
        didSet {
            icon.image = content?.image
            label.text = content?.title
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapHandle))
        wrapper.addGestureRecognizer(gesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView(){
        
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = true
        contentView.addSubview(wrapper)
        wrapper.addSubview(icon)
        wrapper.addSubview(label)
        
        wrapper._to_top(0)
            ._to_bot(-4)
            ._to_left(2)
            ._to_right(-2)
            .useAL()
        
        icon._to_left(4)
            ._to_top(4)
            ._to_bot(-4)
            .useAL()
        
        icon.widthAnchor
            .constraint(equalTo: icon.heightAnchor, multiplier: 1, constant: 0)
            .isActive = true
        
        label._left_to_right(icon, 2)
            ._to_right(-2)
            .useAL()
        
        label.centerYAnchor
            .constraint(equalTo: wrapper.centerYAnchor)
            .isActive = true
    }
    
    @objc func tapHandle(sender: Any) {
       
        if let delegate = delegate,let tag = content?.tag {
            delegate.select(tag:tag )
        }
    }
}
