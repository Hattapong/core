
import Foundation
import UIKit




// testing api
//let apiUrlBase = "http://150.95.30.84:3310"
//let apiUrlBase = "http://150.95.30.84:30112"

// real api
let apiUrlBase = "http://150.95.30.84:30114"

//let apiUrlBase = "http://10.1.1.71:30123"
//let apiUrlBase = "http://10.1.1.71:20133"

private let shopName = "YNR Gold"
private var shopLogo:UIImage? = nil

func getShopNameText() -> String {
    return shopName
}

func getShopTelText() -> String {
    return  appContext?.tel ?? "ติดต่อร้านค้า"
}

func getShopFacebookText() -> String {
    return shopName
}

func getShopLineText() -> String {
    return shopName
}

func setLogoImage(logo: UIImage?) {
    shopLogo = logo
}

func getLogoImage() -> UIImage {
    return shopLogo ?? UIImage(named: "logo-placeholder")!
}







