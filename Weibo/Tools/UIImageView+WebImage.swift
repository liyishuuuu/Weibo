//
//  UIImageView+WebImage.swift
//  Weibo
//
//  Created by liyishu on 2019/7/13.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import SDWebImage

// MARK: - 隔离
extension UIImageView {
    /// 隔离SDWebImageSDWebImage 设置图像函数
    ///
    /// - Parameters:
    ///   - urlString: urlString
    ///   - placeholderImage: 占位图像
    ///  - isAvadar: 是否头像
    
    func cz_setImage(urlString: String?, placeholderImage: UIImage?, isAvadar: Bool = false) {

        // 处理url
        guard let urlString = urlString,
              let url = URL(string: urlString)  else {
            
            // 设置占位图片
            image = placeholderImage
            return
        }

        // 可选项只是用在swift， OC 有的时候用 ！ 同样可以传nil
        sd_setImage(with: url, placeholderImage: placeholderImage, options: []) { [weak self](image, _, _, _) in
            // 完成回调判断，是否是头像
            if isAvadar {
                self?.image = image?.cz_avatarImage(size: self?.bounds.size)
            }
        }
    }
}
