

import UIKit
//import SideMenu

extension UIView {
    
    func addConstrainsWithFormat(format: String,views: UIView...) {
        
        var viewDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDictionary))
    }
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

extension String {
    
    func asQueryParam() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: .afURLQueryAllowed)
    }
    
    func removeQuote()-> String {
        if self.hasPrefix("\"") && self.hasSuffix("\"") {
            var ret:String = self
            ret.removeFirst(1)
            ret.removeLast(1)
            return ret
        }
        return self
    }
    
    func asDateFormat()-> String {
        //2019-10-24T09:26:00
        
        let cleanInput = self.replacingOccurrences(of: "T", with: "_")
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd_HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy HH:mm:ss"
        dateFormatterPrint.calendar = Calendar(identifier: .buddhist)
        
        if let date = dateFormatterGet.date(from: cleanInput) {
            return dateFormatterPrint.string(from: date)
        } else {
            return self
        }
        
    }
    
    func asDateFormat2()-> String {
        //2019-10-24T09:26:00
        
        let cleanInput = self.replacingOccurrences(of: "T", with: "_")
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd_HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM yy HH:mm:ss"
        dateFormatterPrint.calendar = Calendar(identifier: .buddhist)
        dateFormatterPrint.locale = Locale(identifier: "th")
        
        if let date = dateFormatterGet.date(from: cleanInput) {
            return dateFormatterPrint.string(from: date)
        } else {
            return self
        }
        
    }
    
    func asShortDateFormat()-> String {
        //2019-10-24T09:26:00
        
        let cleanInput = self.replacingOccurrences(of: "T", with: "_")
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd_HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        dateFormatterPrint.calendar = Calendar(identifier: .buddhist)
        
        if let date = dateFormatterGet.date(from: cleanInput) {
            return dateFormatterPrint.string(from: date)
        } else {
            return self
        }
        
    }
    
    
    
    func asShortDateFormat2()-> String {
        //2019-10-24T09:26:00
        
        let cleanInput = self.replacingOccurrences(of: "T", with: "_")
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd_HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM yy"
        dateFormatterPrint.calendar = Calendar(identifier: .buddhist)
        dateFormatterPrint.locale = Locale(identifier: "th")
        
        if let date = dateFormatterGet.date(from: cleanInput) {
            return dateFormatterPrint.string(from: date)
        } else {
            return self
        }
        
    }
    
    func removeNonNumber()-> String {
        let regex = try! NSRegularExpression(pattern: "[^0-9]+", options: NSRegularExpression.Options.caseInsensitive)
        let range = NSMakeRange(0, self.count)
        let modString = regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "")
        return modString
    }
    
    func isThaiId() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[0-9]{13}$", options: NSRegularExpression.Options.caseInsensitive)
            let range = NSMakeRange(0, self.count)
            return regex.numberOfMatches(in: self, options: [], range: range) > 0
        } catch {
            return false
        }
        
    }
    
    func isIsZipCode() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[0-9]{5}$", options: NSRegularExpression.Options.caseInsensitive)
            let range = NSMakeRange(0, self.count)
            return regex.numberOfMatches(in: self, options: [], range: range) > 0
        } catch {
            return false
        }
        
    }
    
    
    func isNumber() -> Bool! {
        let num = Double(self)
        return num != nil
    }
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}

extension Double {
    
    func toString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value:self))
        
        return formattedNumber ?? "error number format"
    }
}
extension Int {
    func toString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .none
        let formattedNumber = numberFormatter.string(from: NSNumber(value:self))
        
        return formattedNumber ?? "error number format"
    }
}
