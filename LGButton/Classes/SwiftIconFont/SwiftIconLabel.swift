//
//  SwiftIconLabel.swift
//  icon
//
//  Created by Sedat Gökbek ÇİFTÇİ on 08/07/16.
//  Copyright © 2016 Sedat Gökbek ÇİFTÇİ. All rights reserved.
//

import UIKit

@IBDesignable
class SwiftIconLabel: UILabel {
    @IBInspectable var Icon: String = "" {
        didSet {
            self.text = Icon
            self.parseIcon()
        }
    }
    
    override func awakeFromNib() {
        self.parseIcon()
    }
}
