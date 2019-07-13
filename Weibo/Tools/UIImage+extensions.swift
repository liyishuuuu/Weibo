//
//  UIImage+extensions.swift
//  Weibo
//
//  Created by liyishu on 2019/7/13.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import SDWebImage

extension UIImage {
    func cz_avatarImage(size: CGSize?,
                        backColor: UIColor = UIColor.white,
                        lineColor: UIColor = UIColor.lightGray) -> UIImage? {
        var size = size
        if size == nil {
            size = self.size
        }
        let rect = CGRect(origin: CGPoint(), size: size!)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        backColor.setFill()
        UIRectFill(rect)

        let path = UIBezierPath(ovalIn: rect)
        path.addClip()

        draw(in: rect)
        let ovalPath = UIBezierPath(ovalIn: rect)
        ovalPath.lineWidth = 2
        lineColor.setStroke()
        lineColor.setStroke()
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndPDFContext()
        return result
    }
}
