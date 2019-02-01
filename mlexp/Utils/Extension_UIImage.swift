//
//  Extension_UIImage.swift
//  mlexp
//
//  Created by zxj on 2019/2/1.
//  Copyright © 2019 Yamin Wei. All rights reserved.
//

import UIKit

extension UIImage {
    func path(with fileName: String) -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        var path = documentsPath?.appending("/imgPath")
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: path!) {
            do {
                try fileManager.createDirectory(at: URL(fileURLWithPath: path!), withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                debugPrint("error: \(error)")
            }
        }
        path = path?.appending("/\(fileName)")
        return path!
    }
    
    func saveToFile() -> Bool {
        var result = false
        if let png = self.pngData() {
            let imageData = NSData(data: png)
            //TODO: 指定保人存的文件名
            let path = self.path(with: "xxxxvF.png")
            result = imageData.write(toFile: path, atomically: true)
        }
        return result
    }
    
    class func readFromFile(path: String) -> UIImage? {
        let img = UIImage(contentsOfFile: path)
        return img
    }
}
