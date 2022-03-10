//
//  NewsObj.swift
//  GoldSavingSTD-ios
//
//  Created by  Quark301 on 20/2/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import Foundation

// MARK: - NewsObj
class NewsObj: Codable {
    var newsID: Int?
    var topic, newsObjDescription: String?
    var imageUrls: [String]?

    enum CodingKeys: String, CodingKey {
        case newsID = "newsId"
        case topic
        case newsObjDescription = "description"
        case imageUrls
    }

    init(newsID: Int?, topic: String?, newsObjDescription: String?, imageUrls: [String]?) {
        self.newsID = newsID
        self.topic = topic
        self.newsObjDescription = newsObjDescription
        self.imageUrls = imageUrls
    }
    
    
    static func parseList(_ jsonData:Data!) -> [NewsObj] {
        
        do {
            let list = try JSONDecoder().decode([NewsObj].self, from: jsonData)
            return list
        } catch _ {
            return []
        }
        
    }
}
