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
    class func image(named:String,fontSize: CGFloat = UIFont.systemFontSize,imageColor: UIColor? = UIColor.black)->UIImage?{
        var finalNamed = named

        if let tmpNamed = named.iconFontString() {
            finalNamed = tmpNamed
        }

        if let image = UIImage(named: finalNamed) {
            return image
        }

        if #available(iOS 13.0, *) {
            if let image = UIImage(systemName: finalNamed) {
                guard let imageColor = imageColor else {
                    return image
                }

                return image.withTintColor(imageColor, renderingMode: .alwaysOriginal)
            }
        }

        if let image = UIImage.init(text:finalNamed,fontSize: fontSize, imageColor:imageColor) {
            return image
        }

        return nil
    }

    public convenience init?(text: String, fontSize: CGFloat = UIFont.systemFontSize, imageColor: UIColor? = nil) {
        let mainScale:CGFloat = UIScreen.main.scale
        let fontScaleSize = fontSize * mainScale
        
        guard let iconfont = UIFont.iconfont(ofSize: fontScaleSize) else {
            self.init()
            return nil
        }

        let imageSize = CGSize(width: fontScaleSize, height: fontScaleSize)
        let imageRect = CGRect(origin: CGPoint.zero, size: imageSize)

        UIGraphicsBeginImageContextWithOptions(imageRect.size, false, mainScale)
        defer {
              UIGraphicsEndImageContext()
        }

        let label = UILabel.init(frame:imageRect)
        label.font = iconfont
        label.text = text;
        label.textAlignment = .center
        
        if imageColor != nil{
            label.textColor = imageColor;
        }

        if let currentContext = UIGraphicsGetCurrentContext(){
            label.layer.render(in:currentContext)
        }

        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            self.init()
            return nil
        }
        self.init(cgImage: cgImage, scale: mainScale, orientation: .up)
    }
}

public enum Iconfont: String {
    case homeNormal     = "\u{f3c4}"
    case homeSelect     = "\u{f3c5}"
    case folderNormal   = "\u{f3c7}"
    case folderSelect   = "\u{f3be}"
    case image1         = "\u{e6ab}"
}
