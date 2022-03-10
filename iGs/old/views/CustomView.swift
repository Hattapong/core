
import UIKit

class CustomView: UIView {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        
    }
    
    
    func loadNib(_ nibName:String) {
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
    }
    
    
}

extension UINib {
    func instantiate() -> Any? {
        return self.instantiate(withOwner: nil, options: nil).first
    }
}


extension UIView {

    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    func addEmbedView(contentView: UIView) {
        addSubview(contentView)
        
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }

    static func instantiate(autolayout: Bool = true) -> Self {
        // generic helper function
        func instantiateUsingNib<T: UIView>(autolayout: Bool) -> T {
            let view = self.nib.instantiate() as! T
            view.translatesAutoresizingMaskIntoConstraints = !autolayout
            return view
        }
        return instantiateUsingNib(autolayout: autolayout)
    }
}


/*
 

 class PriceView: CustomView {
     @IBOutlet weak var contentView: UIView!
     
     
     override func commonInit(){
         
         loadNib(String(describing: PriceView.self))
         addEmbedView(contentView: contentView)
             
     }
 }

 
 */

