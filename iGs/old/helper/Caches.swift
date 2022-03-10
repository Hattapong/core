//
//  Caches.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 28/10/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import UIKit


let KEY_LOGO = "key_logo"

class Caches {

func cacheLogo(image: UIImage){
    let imageData = image.pngData()
    UserDefaults.standard.set(imageData, forKey: KEY_LOGO)
    
}


func getCacheLogo() -> UIImage? {
    guard let imageData = UserDefaults.standard.data(forKey: KEY_LOGO) else { return nil}
    
    return UIImage(data: imageData)
}

}
