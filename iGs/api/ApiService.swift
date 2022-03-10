//
//  ApiService.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 8/7/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import Alamofire

class ApiService: NSObject {

static let shared = ApiService()

    func findShop(keyword:String ,success:((_ result:ShopDto) -> Void)?,
                           error:((_ error:Error) -> Void)?,
                           completed:(() -> Void)?) {
        let router = Router.findShop(keyword: keyword)
        AF.request(router).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(ShopDto.self, from:
                        response.data!) //Decode JSON Response Data
                    success?(result)
                } catch let err {
                    error?(err)
                }
            case .failure( let err ):
                error?(err)
            }
            completed?()
        }
    }

}
