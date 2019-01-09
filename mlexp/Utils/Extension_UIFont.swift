//
//  Extension_UIFont.swift
//  mlexp
//
//  Created by zxj on 2019/1/9.
//  Copyright © 2019 Yamin Wei. All rights reserved.
//

import UIKit

let fontName = "AmaticSC-Bold"

extension UIFont {
    class var titleFont: UIFont { return UIFont.init(name: "AmaticSC-Bold", size: 22) ?? UIFont.systemFont(ofSize: 22) }
    class var contentFont: UIFont { return UIFont.init(name: "AmaticSC-Bold", size: 17) ?? UIFont.systemFont(ofSize: 17) }
    class var descFont: UIFont { return UIFont.systemFont(ofSize: 16) }
}
