//
//  UIImageExtension.swift
//  iGS_SRV
//
//  Created by Hattapong on 8/9/2564 BE.
//
import UIKit

extension UIImage {
    
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    func isAllow(limitMB: Double) -> Bool{
        guard self.pngData() != nil else { return false }
        
        let mbInByte:Double = 1024 * 1024
        let allowedSize:Double = limitMB * mbInByte
        print("image size: \(self.sizeInByte) bytes.")
        if self.sizeInByte > allowedSize {
            
            return false
        }
        
        return true
    }
    
    var sizeInMB:Double {
        guard let pngData = self.pngData() else { return 0 }
        return Double(pngData.count) / (1024 * 1024)
    }
    
    var sizeInByte:Double {
        guard let pngData = self.pngData() else { return 0 }
        return Double(pngData.count)
    }
    
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
    
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    
    func reduceFile()->UIImage? {
        guard let newSize = self.resized(toWidth: 550) else { return nil }
        
        guard let data = newSize.jpeg(.highest) else {return nil}
        
        return UIImage(data: data)
    }
}
