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
    func cz_setImage(urlString: String?, placeholderImage: UIImage?) {
        guard let urlString = urlString,
              let url = URL(string: urlString)  else {
            image = placeholderImage
            return
        }
        sd_setImage(with: url, placeholderImage: placeholderImage, options: []) { (image, _, _, _) in
            
        }
    }
}
