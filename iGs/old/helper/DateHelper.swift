//
//  DateHelper.swift
//  GoldSavingSTD-ios
//
//  Created by Hattapong on 17/3/2563 BE.
//  Copyright © 2563  Quark301. All rights reserved.
//

import Foundation


func parseAPIDate(_ date: String) -> Date? {
    let formater = DateFormatter()
    formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    formater.calendar = Calendar(identifier: .gregorian)
    formater.locale = Locale.th
    let result = formater.date(from: date)
    return result
}

func getTHLocale() -> Locale {
    return Locale(identifier: "th_TH")
}

extension Locale {
    static var th:Locale {
        return Locale(identifier: "th_TH")
    }
}

extension Date {
    
    func toString(withFormat formatString: String, calendarIdentifier: Calendar.Identifier) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = formatString
        dateFormat.locale = getTHLocale()
        var calendar = Calendar(identifier: calendarIdentifier)
        calendar.locale = getTHLocale()
        dateFormat.calendar = calendar
        
        
        return dateFormat.string(from: self)
    }
    
    
    func toString(withFormat formatString: String) -> String {
        return self.toString(withFormat: formatString, calendarIdentifier: .buddhist)
    }
    
    func toString() -> String {
        return toString(withFormat: "d/M/yy", calendarIdentifier: .buddhist)
    }
}


var nowStr:String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    formatter.calendar = Calendar(identifier: .gregorian)
    let result = formatter.string(from: date)
    return result
}
