//
//  CZMeituanRefreshView.swift
//  Weibo
//
//  Created by liyishu on 2019/8/25.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class CZMeituanRefreshView: CZRefreshView {
    @IBOutlet weak var humanImageView: UIImageView!
    override func awakeFromNib() {
         let image1 = "wm_common_img_loading_list4"
         let image2 = "wm_common_img_loading_list1"
        humanImageView.image = UIImage.animatedImage(with: [UIImage(named: image1)!, UIImage(named: image2)!], duration: 0.5)
  }
}
