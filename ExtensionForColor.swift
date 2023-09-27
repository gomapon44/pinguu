//
//  ExtensionForColor.swift
//  pinguu
//
//  Created by 五十嵐麻奈美 on 2019/06/29.
//  Copyright © 2019 mana. All rights reserved.
//

import UIKit
import Foundation

extension UIColor {
    convenience init(hex: String, alpha: CGFloat) {
        let v = Int("000000" + hex, radix: 16) ?? 0
        let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
        let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
        let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
        self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
    }
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1.0)
    }
    
    convenience init(rgbcode: String) {
        let rgbCodes = rgbcode.components(separatedBy: ",")
        let r = Int(rgbCodes[0])!
        let g = Int(rgbCodes[1])!
        let b = Int(rgbCodes[2])!
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1)
    }
}
