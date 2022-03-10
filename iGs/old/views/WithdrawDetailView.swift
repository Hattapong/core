

import UIKit

class WithdrawDetailView: CustomView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var billnum: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var amount: UILabel!
    
    
    var data: WithdrawingDto? {
        didSet {
            guard let data = data else {
                billnum.text = "-"
                date.text = "-"
                amount.text = "-"
                return
            }
            
            billnum.text = data.billnum
            date.text = data.billdate.asShortDateFormat()
            amount.text = data.withdrawAmt.toString()
            
        }
    }
    override func commonInit(){
        
        loadNib(String(describing: SpendingDetailView.self))
        addEmbedView(contentView: contentView)
        
    }
    
}

