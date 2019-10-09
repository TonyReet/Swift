//
//  IconFontTool.swift
//  SwiftNotes
//
//  Created by TonyReet on 2019/9/24.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import UIKit
import CoreText

let iconFontName = "iconfont";

extension String {
    /// 将Int类型的转为String类型的Unicode码
    func iconFontString() -> String? {
        if self.contains("0x") == false {
            return nil
        }
        
        var iconInt = self.hexStringToInt()
        let xPtr = withUnsafeMutablePointer(to: &iconInt, { $0 })
        return String(bytesNoCopy: xPtr, length: MemoryLayout<UInt32>.size, encoding: String.Encoding.utf32LittleEndian, freeWhenDone: false) ?? nil
    }
    
    func hexStringToInt() -> UInt32 {
        var result:UInt32 = 0
        Scanner(string: self).scanHexInt32(&result)
        return result
    }
}

extension UIFont {
    class func iconfont(ofSize: CGFloat = UIFont.systemFontSize) -> UIFont? {
        return UIFont(name: iconFontName, size: ofSize)
    }
}

extension UILabel {
    public convenience init?(text: String, fontSize: CGFloat = UIFont.systemFontSize) {
        guard let iconfont = UIFont.iconfont(ofSize: fontSize) else {
            self.init()
            return nil
        }

        self.init()
        self.font = iconfont
        self.text = text
    }
}

extension UIImage {
    class func image(named:String,imageSize: CGSize? = CGSize.zero,imageColor: UIColor? = UIColor.black)->UIImage?{
        var finalNamed = named
        
        if let tmpNamed = named.iconFontString() {
            finalNamed = tmpNamed
        }
        
        if let image = UIImage(named: finalNamed) {
            return image
        }
        
        if let image = UIImage.init(text:finalNamed,imageSize:imageSize!, imageColor:imageColor) {
            return image
        }
        
        return nil
    }
    
    public convenience init?(text: String, fontSize: CGFloat = UIFont.systemFontSize, imageSize: CGSize = CGSize.zero, imageColor: UIColor? = nil) {
        guard let iconfont = UIFont.iconfont(ofSize: fontSize) else {
            self.init()
            return nil
        }
        
        var imageRect = CGRect(origin: CGPoint.zero, size: imageSize)
        var mainScale:CGFloat = 2
        if __CGSizeEqualToSize(imageSize, CGSize.zero) {
            imageRect = CGRect(origin: CGPoint.zero, size: text.size(withAttributes: [NSAttributedString.Key.font: iconfont]))
            
            mainScale = UIScreen.main.scale
        }
        
        UIGraphicsBeginImageContextWithOptions(imageRect.size, false, mainScale)
        defer {
            UIGraphicsEndImageContext()
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        
        if let imageColor = imageColor {
            text.draw(in: imageRect, withAttributes: [NSAttributedString.Key.font : iconfont, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor: imageColor])
        }else{
            text.draw(in: imageRect)
        }
        
        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            self.init()
            return nil
        }
        self.init(cgImage: cgImage)
    }
}

public enum Iconfont: String {
    case homeNormal     = "\u{f3c4}"
    case homeSelect     = "\u{f3c5}"
    case folderNormal   = "\u{f3c7}"
    case folderSelect   = "\u{f3be}"
    case image1         = "\u{e6ab}"
}
