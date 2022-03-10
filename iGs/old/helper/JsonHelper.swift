//
//  jsonHelper.swift
//  gpos-ios
//
//  Created by Hattapong on 26/2/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import Foundation
// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}


func parseDataList<T: Decodable>(data:Data) -> [T]?   {
    
    do {
        let model = try newJSONDecoder().decode([T].self, from:data)
        
        return model
    } catch let err {
        print(err.localizedDescription)
        return nil
    }
    
}


func parseData<T: Decodable>(data:Data) -> T?   {
    
    do {
        let model = try newJSONDecoder().decode(T.self, from:data)
        
        return model
    } catch let err {
        print(err.localizedDescription)
        return nil
    }
    
}
