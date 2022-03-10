

import Foundation
import Alamofire

extension Router {
    
    
    var path: String {
        
        switch self {
            
            // MARK: - guest
            
            case .login: return "/api/login"
                
            case .appLogo: return "/api/app-logo"
                
            case .appData: return "/api/app-data"
                
            case .branchsBank: return "/api/app-branch"
                
            case .goldprice: return "/goldprice/full"
                
            case .newFeeds: return "/News/all"
                
            case .findShop(let keyword):
                return ("/api/apimap/" + keyword).asQueryParam()!
                
            
            // MARK: - auth
            
            case .userProfile: return "/api/cus/prof"
            
            case .userContracts: return "/api/gs/ls/contractid"
                
            case .savingBalance: return "/api/gs/bl"
            
            case .goldsavings: return "/api/gs/ls/sv"
            
            case .pendingSavings: return "/api/gs/ls/notapprove"
            
            case .spendingSavings: return "/api/gs/ls/bg"
            
            case .withdraws: return "/api/gs/ls/wd"
                
            case .intPaids: return "/api/pawn/intPay"
            
            case .pawns: return "/api/pawn"
            
            case .pawnToInterests: return "/api/pawn/caninterests"
            
            case .pawnHasRedeem: return "/api/pawn/redeem"
            
            case .pawnPendingInterests: return "/api/pawn/ls/notapprove"
            
            case .pawnDetail(let pawnid): return "/api/pawn/details/" + pawnid
                
            case .addGoldSaving: return "/api/gs/addnew"
            
            case .changePassword: return "/api/cus/cpw"
            
            case .register: return "/api/register"
                
            case .getPawnForShow(let pawnid): return "/api/pawn/pawnint/" + pawnid
            
            case .addInterest: return "/api/pawn/add"
            }
        
        
        
    }
    
    
    
}
