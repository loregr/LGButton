//
//  FontLoader.swift
//  SwiftIconFont
//
//  Created by Sedat Ciftci on 18/03/16.
//  Copyright © 2016 Sedat Gokbek Ciftci. All rights reserved.
//

import UIKit
import Foundation
import CoreText

class FontLoader: NSObject {
    class func loadFont(_ fontName: String) {
        
        let bundle = Bundle(for: FontLoader.self)
        var fontURL = URL(string: "")
        for filePath : String in bundle.paths(forResourcesOfType: "ttf", inDirectory: nil) {
            let filename = NSURL(fileURLWithPath: filePath).lastPathComponent!
            if filename.lowercased().range(of: fontName.lowercased()) != nil {
                fontURL = NSURL(fileURLWithPath: filePath) as URL
            }
        }
        
        do
        {
            let data = try Data(contentsOf: fontURL!)
            
            let provider = CGDataProvider(data: data as CFData)
            let font = CGFont.init(provider!)
            
            var error: Unmanaged<CFError>?
            if !CTFontManagerRegisterGraphicsFont(font!, &error) {
                let errorDescription: CFString = CFErrorCopyDescription(error!.takeUnretainedValue())
                let nsError = error!.takeUnretainedValue() as AnyObject as! NSError
                NSException(name: NSExceptionName.internalInconsistencyException, reason: errorDescription as String, userInfo: [NSUnderlyingErrorKey: nsError]).raise()
            }
            
        } catch {
            
        }
        
        
    }
}
