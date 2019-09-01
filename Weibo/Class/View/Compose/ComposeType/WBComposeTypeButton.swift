//
//  WBComposeTypeButton.swift
//  Weibo
//
//  Created by liyishu on 2019/8/31.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class WBComposeTypeButton: UIControl {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    // 点击按钮要展示控制器的类名
    var clsName: String?

    // 使用图像名称创键按钮，按钮布局从Xib加载
    class func composeTypeButton(imageName: String, title: String) -> WBComposeTypeButton {
        let nib = UINib(nibName: "WBComposeTypeButton", bundle: nil)
        let btn = nib.instantiate(withOwner: nil, options: nil)[0] as! WBComposeTypeButton
        btn.imageView.image = UIImage(named: imageName)
        btn.titleLabel.text = title
        return btn
    }
}
