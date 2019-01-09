//
//  Extension_UIColor.swift
//  mlexp
//
//  Created by zxj on 2019/1/9.
//  Copyright © 2019 Yamin Wei. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat) {
        var cString = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        let mask = 0x0000FF
        let r = Int(rgbValue >> 16) & mask
        let g = Int(rgbValue >> 8) & mask
        let b = Int(rgbValue) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    class var mYellowColor: UIColor { return UIColor(hexString: "#F5DA44", alpha: 1) }
    class var mBrownColor: UIColor { return UIColor(hexString: "#4C3520", alpha: 1) }
}
