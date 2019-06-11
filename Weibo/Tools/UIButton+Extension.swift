//
//  UIButton+Extension.swift
//  Weibo
//
//  Created by liyishu on 2019/6/9.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    /// 创建 UIBarButtonItem
    ///
    /// - Parameters:
    ///   - parameters title
    ///   - parameters target
    ///   - parameters action
    ///   - parameters isBack: 是否是返回按钮  如果是则加上箭头
    convenience init(title: String, target: AnyObject?, action: Selector, isBack: Bool = false) {
        let btn: UIButton = UIButton()
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.setTitleColor(UIColor.orange, for: .highlighted)
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        if isBack {
            let imageName = "lefterbackicon_titlebar"
            btn.setImage(UIImage(named: imageName), for: UIControl.State(rawValue: 0))
            btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
            btn.sizeToFit()
        }
        
        /// self.init 实例化UIButtonItem
        self.init(customView: btn)
    }
}
