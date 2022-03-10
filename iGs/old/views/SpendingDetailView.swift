

import UIKit

class SpendingDetailView: CustomView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var billnum: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var amount: UILabel!
    
    
    var data: SpendingDto? {
        didSet {
            guard let data = data else {
                billnum.text = "-"
                date.text = "-"
                amount.text = "-"
                return
            }
            
            billnum.text = data.refnum
            date.text = data.sellDate.asShortDateFormat()
            amount.text = data.amt.toString()
            
        }
    }
    override func commonInit(){
        
        loadNib(String(describing: SpendingDetailView.self))
        addEmbedView(contentView: contentView)
        
    }
    
}
