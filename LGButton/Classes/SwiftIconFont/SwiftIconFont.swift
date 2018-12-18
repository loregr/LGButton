//
//  UIFont+SwiftIconFont.swift
//  SwiftIconFont
//
//  Created by Sedat Ciftci on 18/03/16.
//  Copyright © 2016 Sedat Gokbek Ciftci. All rights reserved.
//

import UIKit

public class SwiftIconFont {
    private (set) static var fonts: [String: IconFont] = [:]
    
    private init() {
        
    }
    
    public static func registFont(from font: IconFont, name: String) {
        self.fonts[name] = font
    }
}

public protocol IconFont {
    var fontName: String {get}
    var icons: [String: String] {get}
}

public enum Fonts: IconFont {
    case FontAwesome// = "FontAwesome"
    case Iconic// = "open-iconic"
    case Ionicon// = "Ionicons"
    case Octicon// = "octicons"
    case Themify// = "themify"
    case MapIcon// = "map-icons"
    case MaterialIcon// = "MaterialIcons-Regular"
    
    public var fontName: String {
        switch self {
        case .FontAwesome:
            return "FontAwesome"
        case .Iconic:
            return "Icons"
        case .Ionicon:
            return "Ionicons"
        case .Octicon:
            return "octicons"
        case .Themify:
            return "Themify"
        case .MapIcon:
            return "map-icons"
        case .MaterialIcon:
            return "Material Icons"
        }
    }
    
    public var icons: [String : String] {
        switch self {
        case .FontAwesome:
            return fontAwesomeIconArr//"FontAwesome"
        case .Iconic:
            return iconicIconArr//"Icons"
        case .Ionicon:
            return ioniconArr//"Ionicons"
        case .Octicon:
            return octiconArr//"octicons"
        case .Themify:
            return temifyIconArr//"Themify"
        case .MapIcon:
            return mapIconArr//"map-icons"
        case .MaterialIcon:
            return materialIconArr//"Material Icons"
        }
    }
}
public extension UIFont{
    static func icon(from font: IconFont, ofSize size: CGFloat) -> UIFont {
        let fontName = font.fontName
        if (UIFont.fontNames(forFamilyName: font.fontName).count == 0)
        {
            /*
            dispatch_once(&token) {
                FontLoader.loadFont(fontName)
            }
            */
            FontLoader.loadFont(fontName)
        }
        return UIFont(name: font.fontName, size: size)!
    }
}

public extension UIImage
{
    public static func icon(from font: IconFont, iconColor: UIColor, code: String, imageSize: CGSize, ofSize size: CGFloat) -> UIImage
    {
        let drawText = String.getIcon(from: font, code: code)
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        #if swift(>=4.2)
        drawText!.draw(in: CGRect(x:0, y:0, width:imageSize.width, height:imageSize.height), withAttributes: [NSAttributedString.Key.font : UIFont.icon(from: font, ofSize: size), NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor: iconColor])
        #else
        drawText!.draw(in: CGRect(x:0, y:0, width:imageSize.width, height:imageSize.height), withAttributes: [NSAttributedStringKey.font : UIFont.icon(from: font, ofSize: size), NSAttributedStringKey.paragraphStyle: paragraphStyle, NSAttributedStringKey.foregroundColor: iconColor])
        #endif
		
        
		let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}

public extension String {
    public static func getIcon(from font: IconFont, code: String) -> String? {
        if let icon = font.icons[code] {
            return icon
        }
        return nil
    }
}

func replace(withText string: NSString) -> NSString {
    if string.lowercased.range(of: "-") != nil {
        return string.replacingOccurrences(of: "-", with: "_") as NSString
    }
    return string
}


func getAttributedString(_ text: NSString, ofSize size: CGFloat) -> NSMutableAttributedString {
    let attributedString = NSMutableAttributedString(string: text as String)
    
    for substring in ((text as String).split{$0 == " "}.map(String.init)) {
        var splitArr = ["", ""]
        splitArr = substring.split{$0 == ":"}.map(String.init)
        if splitArr.count < 2 {
            continue
        }
        
        
        let substringRange = text.range(of: substring)
        
        let fontPrefix: String  = splitArr[0].lowercased()
        var fontCode: String = splitArr[1]
        
        if fontCode.lowercased().range(of: "_") != nil {
            fontCode = (fontCode as NSString).replacingOccurrences(of: "_", with: "-")
        }
        
        var fontType: IconFont = Fonts.FontAwesome
        var fontArr: [String: String] = ["": ""]

        if let iconFont = SwiftIconFont.fonts[fontPrefix] {
            fontType = iconFont
            fontArr = iconFont.icons
        }
        
        if let _ = fontArr[fontCode] {
            attributedString.replaceCharacters(in: substringRange, with: String.getIcon(from: fontType, code: fontCode)!)
            let newRange = NSRange(location: substringRange.location, length: 1)
            #if swift(>=4.2)
            attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.icon(from: fontType, ofSize: size), range: newRange)
            #else
            attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.icon(from: fontType, ofSize: size), range: newRange)
            #endif
        }
    }
    
    return attributedString
}

func GetIconIndexWithSelectedIcon(_ icon: String) -> String {
    let text = icon as NSString
    var iconIndex: String = ""
    
    for substring in ((text as String).split{$0 == " "}.map(String.init)) {
        var splitArr = ["", ""]
        splitArr = substring.split{$0 == ":"}.map(String.init)
        if splitArr.count == 1{
            continue
        }
        
        var fontCode: String = splitArr[1]
        
        if fontCode.lowercased().range(of: "_") != nil {
            fontCode = (fontCode as NSString).replacingOccurrences(of: "_", with: "-")
        }
        iconIndex = fontCode
    }
    
    return iconIndex
}

func GetFontTypeWithSelectedIcon(_ icon: String) -> IconFont {
    let text = icon as NSString
    var fontType: IconFont = Fonts.FontAwesome
    
    for substring in ((text as String).split{$0 == " "}.map(String.init)) {
        var splitArr = ["", ""]
        splitArr = substring.split{$0 == ":"}.map(String.init)
        
        if splitArr.count == 1{
            continue
        }
        
        let fontPrefix: String  = splitArr[0].lowercased()
        var fontCode: String = splitArr[1]
        
        if fontCode.lowercased().range(of: "_") != nil {
            fontCode = (fontCode as NSString).replacingOccurrences(of: "_", with: "-")
        }
        
        if let iconFont = SwiftIconFont.fonts[fontPrefix] {
            fontType = iconFont
        }
    }
    
    return fontType
}

// Extensions


public extension UILabel {
    func parseIcon() {
        let text = replace(withText: (self.text! as NSString))
        self.attributedText = getAttributedString(text, ofSize: self.font!.pointSize)
    }
}
