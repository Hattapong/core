//
//  AppData.swift
//  GoldSavingSTD-ios
//
//  Created by  Quark301 on 29/10/2562 BE.
//  Copyright © 2562  Quark301. All rights reserved.
//

import Foundation
import Alamofire
struct AppData : Codable {

        let bankAccount : BankAccount?
        let facebook : String?
        let lineId : String?
        let shopName : String?
        let tel : String?

        

    public static func getAppData(onFinished:(()->Void)?) {
        let router = Router.appData
        AF.request(router).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                do {
                    //here dataResponse received from a network request
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(AppData.self, from:
                        response.data!) //Decode JSON Response Data
                    appContext = model
                } catch let parsingError {
                    print("Error", parsingError)
                }            case .failure(let error):
                print(error)
            }
            
            guard onFinished != nil else { return }
            onFinished!()
        }
    }
}
