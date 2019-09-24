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

extension UIFont {
    class func iconfont(ofSize: CGFloat = UIFont.systemFontSize) -> UIFont? {
        return UIFont(name: iconFontName, size: ofSize)
    }
}

extension UILabel {
    public convenience init?(text: Iconfont, fontSize: CGFloat = UIFont.systemFontSize, imageSize: CGSize = CGSize.zero, imageColor: UIColor = UIColor.black) {
        guard let iconfont = UIFont.iconfont(ofSize: fontSize) else {
            self.init()
            return nil
        }

        self.init()
        self.font = iconfont
    }
}

extension UIImage {
    public convenience init?(text: Iconfont, fontSize: CGFloat = UIFont.systemFontSize, imageSize: CGSize = CGSize.zero, imageColor: UIColor = UIColor.black) {
        guard let iconfont = UIFont.iconfont(ofSize: fontSize) else {
            self.init()
            return nil
        }
        
        var imageRect = CGRect(origin: CGPoint.zero, size: imageSize)
        if __CGSizeEqualToSize(imageSize, CGSize.zero) {
            imageRect = CGRect(origin: CGPoint.zero, size: text.rawValue.size(withAttributes: [NSAttributedString.Key.font: iconfont]))
        }
        
        UIGraphicsBeginImageContextWithOptions(imageRect.size, false, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        text.rawValue.draw(in: imageRect, withAttributes: [NSAttributedString.Key.font : iconfont, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor: imageColor])
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
}
