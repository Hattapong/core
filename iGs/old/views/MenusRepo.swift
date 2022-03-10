

import UIKit



class MenusRepo {
    
    static let TransactionMenus = [
        SubMenuItemContent(#imageLiteral(resourceName: "do_saving_gold"), "do_saving", "ออมทอง", .doSaving),
        SubMenuItemContent(#imageLiteral(resourceName: "do_interest"), "do_interest", "ต่อดอก", .doInterest)
    ]
    
    
    static let HistoryMenus = [
        SubMenuItemContent( #imageLiteral(resourceName: "history_gs"), "history_gs", "ประวัติออมทอง", .gsHistory),
        SubMenuItemContent(#imageLiteral(resourceName: "history_pawn"), "history_pawn", "ประวัติขายฝาก", .pawnHistory)
    ]
    
}
